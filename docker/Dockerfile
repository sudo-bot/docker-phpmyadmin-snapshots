
ARG VERSION_MAJOR="5"
FROM phpmyadmin:${VERSION_MAJOR}

ENV VERSION_RANGE="5.2"
ARG GIST_REVISION="684f06d6802fe32ed4e70ae8a54521cfc1cfc30a"
ARG GIST_URL="https://gist.githubusercontent.com/williamdes/883f2158f17e9ed5a83d892ada56f5df/raw/${GIST_REVISION}/upgradephpmyadmin.sh"

RUN curl -# -o ./upgradephpmyadmin.sh "${GIST_URL}" \
    && chmod +x ./upgradephpmyadmin.sh \
    && echo "Version-range: ${VERSION_RANGE}" \
    && ./upgradephpmyadmin.sh /var/www/ www-data www-data "${VERSION_RANGE}+snapshot" html
