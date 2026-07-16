#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0
#
# End-to-end regression test for upgrading a real, persisted WordPress install across this
# fork's major-version jump (6.9.4, the last image built before this repo had its own
# Dockerfile, to 7.0.0). Boots the actual image against real MariaDB and drives it through
# actual PHP execution (wp-cli's "core update-db"), since a real cross-major upgrade only
# reproduces problems (broken migrations, permission issues, stale wp-config.php assumptions)
# when WordPress's own code actually runs - not from reading the shell libraries in isolation.
#
# Usage: tests/e2e-legacy-upgrade.sh <new-image-ref> [<old-image-ref>]

set -euo pipefail

NEW_IMAGE="${1:?Usage: $0 <new-image-ref> [<old-image-ref>]}"
OLD_IMAGE="${2:-cloudtooling/wordpress:6.9.4}"
NET="wordpress-e2e-net-$$"
DB="wordpress-e2e-db-$$"
APP="wordpress-e2e-app-$$"
VOL="wordpress-e2e-vol-$$"
TEST_POST_TITLE="e2e-legacy-upgrade-marker-$$"

cleanup() {
    docker rm -f "$APP" "$DB" >/dev/null 2>&1 || true
    docker volume rm "$VOL" >/dev/null 2>&1 || true
    docker network rm "$NET" >/dev/null 2>&1 || true
}
trap cleanup EXIT

wait_for_setup_finished() {
    local container="$1"
    # --tail (not full "docker logs") keeps each poll cheap regardless of how much verbose
    # BITNAMI_DEBUG output has accumulated; bounded by wall-clock deadline, not iteration
    # count, since a loaded Docker host can make each poll itself take much longer than
    # "sleep 5" implies.
    local deadline=$(( $(date +%s) + 900 ))
    while [ "$(date +%s)" -lt "$deadline" ]; do
        if docker logs --tail 200 "$container" 2>&1 | grep -q "WordPress setup finished"; then
            return 0
        fi
        if ! docker inspect -f '{{.State.Running}}' "$container" 2>/dev/null | grep -q true; then
            echo "FAIL: $container exited unexpectedly"
            docker logs "$container" 2>&1 | tail -80
            return 1
        fi
        sleep 5
    done
    echo "FAIL: $container never finished WordPress setup"
    docker logs "$container" 2>&1 | tail -60
    return 1
}

wait_for_http_200() {
    local container="$1"
    local deadline=$(( $(date +%s) + 900 ))
    while [ "$(date +%s)" -lt "$deadline" ]; do
        if docker exec "$container" bash -c 'exec 3<>/dev/tcp/127.0.0.1/8080 && printf "GET / HTTP/1.0\r\nHost: localhost\r\n\r\n" >&3 && head -1 <&3' 2>/dev/null | grep -q "200"; then
            return 0
        fi
        if ! docker inspect -f '{{.State.Running}}' "$container" 2>/dev/null | grep -q true; then
            echo "FAIL: $container exited unexpectedly"
            docker logs "$container" 2>&1 | tail -80
            return 1
        fi
        sleep 5
    done
    echo "FAIL: never got a healthy 200 from $container"
    docker logs "$container" 2>&1 | tail -80
    return 1
}

echo "==> Setting up network/volume"
docker network create "$NET" >/dev/null
docker volume create "$VOL" >/dev/null

echo "==> Starting MariaDB"
docker run -d --name "$DB" --network "$NET" \
    -e ALLOW_EMPTY_PASSWORD=yes \
    -e MARIADB_USER=bn_wordpress \
    -e MARIADB_DATABASE=bitnami_wordpress \
    -e MARIADB_CHARACTER_SET=utf8mb4 \
    -e MARIADB_COLLATE=utf8mb4_unicode_ci \
    docker.io/bitnami/mariadb:latest >/dev/null

echo "==> Fresh install: booting the old image ($OLD_IMAGE) against empty volumes"
docker run -d --name "$APP" --network "$NET" \
    -v "${VOL}:/bitnami/wordpress" \
    -e WORDPRESS_DATABASE_HOST="$DB" \
    -e WORDPRESS_DATABASE_PORT_NUMBER=3306 \
    -e WORDPRESS_DATABASE_USER=bn_wordpress \
    -e WORDPRESS_DATABASE_NAME=bitnami_wordpress \
    -e ALLOW_EMPTY_PASSWORD=yes \
    -e WORDPRESS_USERNAME=admin \
    -e WORDPRESS_PASSWORD='Sup3rSecret!' \
    -e WORDPRESS_EMAIL=admin@example.com \
    -e BITNAMI_DEBUG=true \
    "$OLD_IMAGE" >/dev/null

wait_for_setup_finished "$APP"
echo "==> Fresh install OK"

echo "==> Creating a marker post to verify content survives the upgrade"
docker exec "$APP" wp post create --post_title="$TEST_POST_TITLE" --post_status=publish >/dev/null
echo "==> Marker post created"

echo "==> Stopping old container, keeping the volume"
docker rm -f "$APP" >/dev/null

echo "==> Restarting against the same volume with the new image ($NEW_IMAGE) - this must run the real 'wp core update-db' upgrade"
docker run -d --name "$APP" --network "$NET" \
    -v "${VOL}:/bitnami/wordpress" \
    -e WORDPRESS_DATABASE_HOST="$DB" \
    -e WORDPRESS_DATABASE_PORT_NUMBER=3306 \
    -e WORDPRESS_DATABASE_USER=bn_wordpress \
    -e WORDPRESS_DATABASE_NAME=bitnami_wordpress \
    -e ALLOW_EMPTY_PASSWORD=yes \
    -e WORDPRESS_USERNAME=admin \
    -e WORDPRESS_PASSWORD='Sup3rSecret!' \
    -e WORDPRESS_EMAIL=admin@example.com \
    -e BITNAMI_DEBUG=true \
    "$NEW_IMAGE" >/dev/null

wait_for_setup_finished "$APP"
wait_for_http_200 "$APP"

echo "==> Verifying WordPress core actually reports the new version"
new_version="$(docker exec "$APP" wp core version)"
echo "    wp core version: $new_version"
if [[ "$new_version" != 7.0 && "$new_version" != 7.0.* ]]; then
    echo "FAIL: expected an upgraded 7.0.x core version, got '$new_version'"
    exit 1
fi

echo "==> Verifying content created on the old version survived the upgrade"
if ! docker exec "$APP" wp post list --post_type=post --field=post_title | grep -qF "$TEST_POST_TITLE"; then
    echo "FAIL: marker post created on the old image is missing after the upgrade"
    docker exec "$APP" wp post list --post_type=post --field=post_title || true
    exit 1
fi

echo "==> PASS: WordPress upgraded from $OLD_IMAGE to $NEW_IMAGE in place, database migrated, content preserved"
