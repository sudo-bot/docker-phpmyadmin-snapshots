
ARG VERSION_MAJOR="5"
FROM phpmyadmin:${VERSION_MAJOR}

ARG VERSION_RANGE

ARG GIST_REVISION="462a4fde9c82f4e0b028e35c751625d278d8303c"
ARG GIST_URL="https://gist.githubusercontent.com/williamdes/883f2158f17e9ed5a83d892ada56f5df/raw/${GIST_REVISION}/upgradephpmyadmin.sh"

RUN set -eux; \
    curl -# -o ./upgradephpmyadmin.sh "${GIST_URL}"; \
    chmod +x ./upgradephpmyadmin.sh; \
    echo "Version-range: ${VERSION_RANGE}"; \
    ./upgradephpmyadmin.sh /var/www/ www-data www-data "${VERSION_RANGE}+snapshot" html; \
    export CONFIG_FILE="/var/www/html/libraries/vendor_config.php"; \
    if [ ! -f $CONFIG_FILE ]; then export CONFIG_FILE="/var/www/html/app/vendor_config.php"; fi; \
    # Source: https://github.com/phpmyadmin/docker/blob/905cae841eff6eb0d24755435f44e26af0488093/apache/Dockerfile#L112-L115
    grep -q -F "'configFile' => ROOT_PATH . 'config.inc.php'," $CONFIG_FILE; \
    sed -i "s@'configFile' => .*@'configFile' => '/etc/phpmyadmin/config.inc.php',@" $CONFIG_FILE; \
    grep -q -F "'configFile' => '/etc/phpmyadmin/config.inc.php'," $CONFIG_FILE; \
    php -l $CONFIG_FILE;
