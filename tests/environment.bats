#!/usr/bin/env bats
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0
#
# Guards the rootfs/opt/bitnami/scripts/wordpress-env.sh defaults that
# charts/wordpress/templates/deployment.yaml - and, transitively, the production "blogs"
# release in the hosting repo - rely on. A silent rename or default change here would break
# WORDPRESS_OVERRIDE_DATABASE_SETTINGS-driven external-database wiring or
# WORDPRESS_DATA_TO_PERSIST-driven volume persistence without any chart-level warning, since
# both are only ever exercised at runtime against a real database.

@test "WORDPRESS_DATA_TO_PERSIST defaults to wp-config.php and wp-content" {
    run bash -c '. /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_DATA_TO_PERSIST"'
    [ "$status" -eq 0 ]
    [ "$output" = "wp-config.php wp-content" ]
}

@test "WORDPRESS_DATA_TO_PERSIST can be overridden (the hosting chart adds wp-content/uploads and wordfence-waf.php)" {
    run bash -c 'WORDPRESS_DATA_TO_PERSIST="wp-config.php wp-content/uploads wordfence-waf.php"; . /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_DATA_TO_PERSIST"'
    [ "$status" -eq 0 ]
    [ "$output" = "wp-config.php wp-content/uploads wordfence-waf.php" ]
}

@test "WORDPRESS_DATABASE_NAME defaults to bitnami_wordpress" {
    run bash -c '. /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_DATABASE_NAME"'
    [ "$status" -eq 0 ]
    [ "$output" = "bitnami_wordpress" ]
}

@test "WORDPRESS_DATABASE_USER defaults to bn_wordpress" {
    run bash -c '. /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_DATABASE_USER"'
    [ "$status" -eq 0 ]
    [ "$output" = "bn_wordpress" ]
}

@test "WORDPRESS_DATABASE_PORT_NUMBER defaults to 3306" {
    run bash -c '. /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_DATABASE_PORT_NUMBER"'
    [ "$status" -eq 0 ]
    [ "$output" = "3306" ]
}

@test "WORDPRESS_OVERRIDE_DATABASE_SETTINGS defaults to no" {
    run bash -c '. /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_OVERRIDE_DATABASE_SETTINGS"'
    [ "$status" -eq 0 ]
    [ "$output" = "no" ]
}

@test "WORDPRESS_OVERRIDE_DATABASE_SETTINGS=yes is respected (the hosting chart sets this to point wp-config.php at the shared MariaDB)" {
    run bash -c 'WORDPRESS_OVERRIDE_DATABASE_SETTINGS=yes; . /opt/bitnami/scripts/wordpress-env.sh >/dev/null 2>&1; echo "$WORDPRESS_OVERRIDE_DATABASE_SETTINGS"'
    [ "$status" -eq 0 ]
    [ "$output" = "yes" ]
}
