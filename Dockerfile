FROM alpine

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]

ENV OAUTH2_PROXY_CLIENT_ID=CLIENT_ID \
    OAUTH2_PROXY_CLIENT_SECRET=CLIENT_SECRET \
    OAUTH2_PROXY_COOKIE_SECRET=SOMESECRETSTUFFSIXR \
    OAUTH2_PROXY_COOKIE_DOMAIN=foobar.com

RUN apk add --no-cache nginx ca-certificates wget &&\ 
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main dumb-init &&\ 
    wget -q -O /tmp/oauth_proxy.tar https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz &&\
    tar -xf /tmp/oauth_proxy.tar -C ./bin --strip-components=1 &&\
    chmod +x /bin/oauth2_proxy &&\
    apk del wget

COPY entrypoint.sh /entrypoint.sh
COPY oauth2_proxy.cfg /etc/oauth2_proxy.cfg
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
