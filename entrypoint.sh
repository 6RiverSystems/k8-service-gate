#!/bin/ash
# shellcheck shell=dash

RESOLVER_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'e)
sed -i "s/\$RESOLVER_IP/${RESOLVER_IP}/g" /etc/nginx/conf.d/default.conf
sed -i "s/\$SERVICE_NAME/${SERVICE_NAME}/g" /etc/nginx/conf.d/default.conf

mkdir -p /run/nginx
touch /run/nginx/nginx.pid

/bin/oauth2_proxy -set-xauthrequest --upstream=http://127.0.0.1:80/ --email-domain=${EMAIL_DOMAIN} -config=/etc/oauth2_proxy.cfg &
/usr/sbin/nginx -g 'daemon off;'
