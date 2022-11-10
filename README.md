# phpMyAdmin Docker snapshots

## What is different from the [official image](https://hub.docker.com/_/phpmyadmin) ?

Nothing expect the contents of `/var/www/html`.

## Documentation

Please refer to the [official image](https://hub.docker.com/_/phpmyadmin) is you have any questions.

## How to use

### 5.2 versions

```diff
- image: phpmyadmin:5
+ image: botsudo/phpmyadmin-snapshots:5.2-snapshot
```

### 5.3 versions

```diff
- image: phpmyadmin:5
+ image: botsudo/phpmyadmin-snapshots:5.3-snapshot
```

## Is my architecture supported ?

We support as much as the base image [(`phpmyadmin:5`)](https://hub.docker.com/_/phpmyadmin/tags), this is:

- `linux/386`
- `linux/amd64`
- `linux/arm/v5`
- `linux/arm/v7`
- `linux/arm64/v8`
- `linux/mips64le`
- `linux/ppc64le`
- `linux/s390x`
