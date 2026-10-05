# Wordpress

Wordpress Docker Image &amp; Helm Chart. Based on Bitnami Charts and Images

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/wordpress-ng)](https://artifacthub.io/packages/helm/wordpress-ng/wordpress)
[![Docker Stars](https://img.shields.io/docker/pulls/cloudtooling/wordpress)](https://hub.docker.com/r/cloudtooling/wordpress/)
[![Docker Stars](https://img.shields.io/docker/stars/cloudtooling/wordpress.svg)](https://hub.docker.com/r/cloudtooling/wordpress/)

## Usage

### Docker image

Published to [Docker Hub](https://hub.docker.com/r/cloudtooling/wordpress/tags) by
[`.github/workflows/build.yml`](.github/workflows/build.yml): `next` and a numeric
`<run-id>` tag on every push to `develop`, and `latest` plus the released version (e.g.
`7.0.0`) whenever a version tag is pushed. Pin to a released version tag in anything other
than a throwaway environment — `next`/`latest` move.

```console
docker pull cloudtooling/wordpress:7.0.0
```

[`Dockerfile`](Dockerfile) + [`prebuildfs`](prebuildfs)/[`rootfs`](rootfs) rebuild the
Bitnami WordPress image from Bitnami's own still-public `downloads.bitnami.com/files/stacksmith`
component packages (Apache, PHP, the various `*-client`/`*-lib` packages, and WordPress
itself), rather than depending on any `bitnami/*` or `bitnamilegacy/*` image — the same
approach used in the [moodle](https://github.com/CloudTooling/moodle) fork. `WORDPRESS_VERSION`
is currently pinned to `7.0.0`, the last version Bitnami built before splitting free/paid
image support (see [`bitnami/containers`](https://github.com/bitnami/containers)); there is
no newer open component build to move to yet.

It's a drop-in for `bitnami/wordpress`: same environment variables
(`WORDPRESS_DATABASE_*`, `WORDPRESS_USERNAME`/`WORDPRESS_PASSWORD`, `SMTP_*`, ...), same
`/bitnami/wordpress` volume layout. See [`docker-compose.yml`](docker-compose.yml) for a
minimal local run against real MariaDB (`docker compose up`).

### Helm chart

[`charts/wordpress`](charts/wordpress) is a vendored-and-modified fork of Bitnami's official
`wordpress` Helm chart (currently tracking `helm pull
oci://registry-1.docker.io/bitnamicharts/wordpress --version 32.1.12` — unlike the component
image tarballs the Dockerfile pulls, Bitnami keeps publishing chart updates, so this can move
independently and ahead of `WORDPRESS_VERSION`), with the `image.repository`/`image.tag`
defaults pointed at `cloudtooling/wordpress:7.0.0` instead of `bitnami/wordpress`:

```console
helm install my-release ghcr.io/cloudtooling/helm-charts \
  --set wordpressUsername=admin \
  --set wordpressPassword=<password> \
  --set externalDatabase.host=<mariadb-host> \
  --set externalDatabase.password=<db-password>
```

See [`charts/wordpress/values.yaml`](charts/wordpress/values.yaml) for the full parameter
list (it's a fork of Bitnami's chart, so upstream's
[parameter docs](charts/wordpress/README.md) mostly still apply).

## Releasing

Run the **Create release** workflow (`.github/workflows/release.yml`, built on
[`m13tLabs/gh-actions-templates`](https://github.com/m13tLabs/gh-actions-templates)'
`docker-release.yml`) from `develop`:

- `release_version`: the WordPress version, optionally with an image revision for
  image-only fixes (e.g. `7.1.2.1`).
- `chart_version` (optional): the Helm chart version. Empty patch-bumps the current
  one; an explicit `X.Y.Z` must be higher than the current chart version.
- `draft_release`: create the GitHub release as a draft (default).

The release commit pins the chart to the image it publishes
([`scripts/pin-release-version.sh`](scripts/pin-release-version.sh)): `image.tag`,
`appVersion` and the `annotations.images` entry become the release version, and
the chart README is regenerated with helm-docs. The chart is then pushed to
`oci://ghcr.io/cloudtooling/helm-charts`. Don't bump these by hand or via Renovate;
the chart must only ever point at an image a release has already published.
