
ARG VERSION_MAJOR="5"
FROM phpmyadmin:${VERSION_MAJOR}

ARG VERSION_RANGE

ARG GIST_REVISION="448611c5cefb75d88c81cc17810089fef7c23032"
ARG GIST_URL="https://gist.githubusercontent.com/williamdes/883f2158f17e9ed5a83d892ada56f5df/raw/${GIST_REVISION}/upgradephpmyadmin.sh"

RUN curl -# -o ./upgradephpmyadmin.sh "${GIST_URL}" \
    && chmod +x ./upgradephpmyadmin.sh \
    && echo "Version-range: ${VERSION_RANGE}" \
    && ./upgradephpmyadmin.sh /var/www/ www-data www-data "${VERSION_RANGE}+snapshot" html \
    # Source: https://github.com/phpmyadmin/docker/blob/905cae841eff6eb0d24755435f44e26af0488093/apache/Dockerfile#L112-L115
    && grep -q -F "'configFile' => ROOT_PATH . 'config.inc.php'," /var/www/html/libraries/vendor_config.php \
    && sed -i "s@'configFile' => .*@'configFile' => '/etc/phpmyadmin/config.inc.php',@" /var/www/html/libraries/vendor_config.php \
    && grep -q -F "'configFile' => '/etc/phpmyadmin/config.inc.php'," /var/www/html/libraries/vendor_config.php \
    && php -l /var/www/html/libraries/vendor_config.php
