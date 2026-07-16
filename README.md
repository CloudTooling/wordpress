# Wordpress

Wordpress Docker Image &amp; Helm Chart. Based on Bitnami Charts and Images

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/wordpress-ng)](https://artifacthub.io/packages/search?repo=wordpress-ng)
[![Docker Stars](https://img.shields.io/docker/pulls/cloudtooling/wordpress)](https://hub.docker.com/r/cloudtooling/wordpress/)
[![Docker Stars](https://img.shields.io/docker/stars/cloudtooling/wordpress.svg)](https://hub.docker.com/r/cloudtooling/wordpress/)

## Usage

### Docker image

For now this chart consumes `cloudtooling/wordpress:6.9.4`, a manually-built image based on
Bitnami's last free `bitnami/wordpress` release. A proper `Dockerfile` +
`prebuildfs`/`rootfs` rebuild (rebuilding from Bitnami's still-public stacksmith component
packages, the same approach used in the [moodle](https://github.com/CloudTooling/moodle)
fork) is planned but not done yet.

```console
docker pull cloudtooling/wordpress:6.9.4
```

It's a drop-in for `bitnami/wordpress`: same environment variables
(`WORDPRESS_DATABASE_*`, `WORDPRESS_USERNAME`/`WORDPRESS_PASSWORD`, `SMTP_*`, ...), same
`/bitnami/wordpress` volume layout.

### Helm chart

[`charts/wordpress`](charts/wordpress) is a vendored-and-modified fork of Bitnami's official
`wordpress` Helm chart (last free version pulled via
`helm pull oci://registry-1.docker.io/bitnamicharts/wordpress --version 30.1.8`), with the
`image.repository`/`image.tag` defaults pointed at `cloudtooling/wordpress:6.9.4` instead of
`bitnami/wordpress`. It is not yet published to a chart repository or OCI registry from CI —
consume it directly from a checkout of this repo until that's wired up:

```console
helm install my-release ./charts/wordpress \
  --set wordpressUsername=admin \
  --set wordpressPassword=<password> \
  --set externalDatabase.host=<mariadb-host> \
  --set externalDatabase.password=<db-password>
```

See [`charts/wordpress/values.yaml`](charts/wordpress/values.yaml) for the full parameter
list (it's a fork of Bitnami's chart, so upstream's
[parameter docs](charts/wordpress/README.md) mostly still apply).
