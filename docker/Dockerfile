
ARG VERSION_MAJOR="5"
FROM phpmyadmin:${VERSION_MAJOR}

ARG VERSION_RANGE

ARG GIST_REVISION="448611c5cefb75d88c81cc17810089fef7c23032"
ARG GIST_URL="https://gist.githubusercontent.com/williamdes/883f2158f17e9ed5a83d892ada56f5df/raw/${GIST_REVISION}/upgradephpmyadmin.sh"

RUN curl -# -o ./upgradephpmyadmin.sh "${GIST_URL}" \
    && chmod +x ./upgradephpmyadmin.sh \
    && echo "Version-range: ${VERSION_RANGE}" \
    && ./upgradephpmyadmin.sh /var/www/ www-data www-data "${VERSION_RANGE}+snapshot" html
