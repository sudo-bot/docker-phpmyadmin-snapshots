# phpMyAdmin Docker snapshots

[![Docker size 5.2](https://img.shields.io/docker/image-size/botsudo/phpmyadmin-snapshots/5.2-snapshot?style=flat-square)](https://hub.docker.com/r/botsudo/phpmyadmin-snapshots)
[![Docker size 6.0](https://img.shields.io/docker/image-size/botsudo/phpmyadmin-snapshots/6.0-snapshot?style=flat-square)](https://hub.docker.com/r/botsudo/phpmyadmin-snapshots)

## What is different from the [official image](https://hub.docker.com/_/phpmyadmin) ?

Nothing expect the contents of `/var/www/html`.

## Documentation

Please refer to the [official image](https://hub.docker.com/_/phpmyadmin) is you have any questions.

This image can be found on [Docker Hub: botsudo/phpmyadmin-snapshots](https://hub.docker.com/r/botsudo/phpmyadmin-snapshots)

Dockerfiles can be found on [GitHub: sudo-bot/docker-phpmyadmin-snapshots](https://github.com/sudo-bot/docker-phpmyadmin-snapshots)

## How to use

### 5.2 versions (currently in support for bug fixes)

```diff
- image: phpmyadmin:5
+ image: botsudo/phpmyadmin-snapshots:5.2-snapshot
```

### 6.0 versions (not released yet, early early testers only !)

Do not use this version if you do not intend to do **early testing!**

```diff
- image: phpmyadmin:latest
+ image: botsudo/phpmyadmin-snapshots:6.0-snapshot
```

## Is there telemetry ?

No. We do not care about it, we want bug reports from our users: https://github.com/phpmyadmin/phpmyadmin/issues/new/choose

## How can I trust this image ?

You can but also should check. Trust also needs to be checked for software !

Install [container-diff](https://github.com/GoogleContainerTools/container-diff).

- File list `container-diff diff --type file remote://phpmyadmin:5 remote://botsudo/phpmyadmin-snapshots:5.2-snapshot`
- As json `container-diff diff --json --type file daemon://phpmyadmin:5 daemon://botsudo/phpmyadmin-snapshots:5.2-snapshot`

[container-diff](https://github.com/GoogleContainerTools/container-diff) is not replaced by [diffoci](https://github.com/reproducible-containers/diffoci).

TLDR;

No system files are changed, at all. The source is installed by [this script/gist](https://gist.github.com/williamdes/883f2158f17e9ed5a83d892ada56f5df) that you can run on your server.

## How can I keep up to date ?

Use [watchtower](https://containrrr.dev/watchtower/).

```yaml
  phpmyadmin-snapshot-5.2:
    image: botsudo/phpmyadmin-snapshots:5.2-snapshot
    # ...
    labels:
      com.centurylinklabs.watchtower.enable: "true"

  watchtower:
    image: containrrr/watchtower
    environment:
        # Only containers with the label: com.centurylinklabs.watchtower.enable
        WATCHTOWER_LABEL_ENABLE: "true"
        # Remove the old container: https://containrrr.dev/watchtower/arguments/#cleanup
        WATCHTOWER_CLEANUP: "true"
        # Also restart the container
        WATCHTOWER_INCLUDE_RESTARTING: "true"
        # Poll interval in seconds (43200 = 12h, 86400 = 24h): https://containrrr.dev/watchtower/arguments/#poll_interval
        WATCHTOWER_POLL_INTERVAL: "43200"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

## Is my architecture supported ?

We support as much as the base image [(`phpmyadmin:5`)](https://hub.docker.com/_/phpmyadmin/tags), this is:

- `linux/386`
- `linux/amd64`
- `linux/arm/v5`
- `linux/arm/v7`
- `linux/arm64/v8`
- `linux/ppc64le`
- `linux/s390x`
