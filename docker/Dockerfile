
ARG VERSION_MAJOR="5"
FROM phpmyadmin:${VERSION_MAJOR}

ARG VERSION_RANGE

ARG GIST_REVISION="91da4f67c2d6f01b9553bbd5da1fe2548224949c"
ARG GIST_URL="https://gist.githubusercontent.com/williamdes/883f2158f17e9ed5a83d892ada56f5df/raw/${GIST_REVISION}/upgradephpmyadmin.sh"

# See: https://github.com/phpmyadmin/website/issues/167#issuecomment-1892467844
# TODO: revert %2B with +
RUN curl -# -o ./upgradephpmyadmin.sh "${GIST_URL}" \
    && chmod +x ./upgradephpmyadmin.sh \
    && echo "Version-range: ${VERSION_RANGE}" \
    && ./upgradephpmyadmin.sh /var/www/ www-data www-data "${VERSION_RANGE}%2Bsnapshot" html \
    # Source: https://github.com/phpmyadmin/docker/blob/905cae841eff6eb0d24755435f44e26af0488093/apache/Dockerfile#L112-L115
    && grep -q -F "'configFile' => ROOT_PATH . 'config.inc.php'," /var/www/html/libraries/vendor_config.php \
    && sed -i "s@'configFile' => .*@'configFile' => '/etc/phpmyadmin/config.inc.php',@" /var/www/html/libraries/vendor_config.php \
    && grep -q -F "'configFile' => '/etc/phpmyadmin/config.inc.php'," /var/www/html/libraries/vendor_config.php \
    && php -l /var/www/html/libraries/vendor_config.php
