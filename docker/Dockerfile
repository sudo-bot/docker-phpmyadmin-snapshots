
ARG VERSION_MAJOR="5"
FROM phpmyadmin:${VERSION_MAJOR}

ENV VERSION_RANGE="5.2"
ARG GIST_REVISION="db3da63fa3925478c5960b86b4c9c2ff5c15541d"
ARG GIST_URL="https://gist.githubusercontent.com/williamdes/883f2158f17e9ed5a83d892ada56f5df/raw/${GIST_REVISION}/upgradephpmyadmin.sh"

RUN curl -# -o ./upgradephpmyadmin.sh "${GIST_URL}" \
    && chmod +x ./upgradephpmyadmin.sh \
    && echo "Version-range: ${VERSION_RANGE}" \
    && ./upgradephpmyadmin.sh /var/www/ www-data www-data "${VERSION_RANGE}+snapshot" html
