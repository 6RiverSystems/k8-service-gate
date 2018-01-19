#!/bin/ash
# shellcheck shell=dash

RESOLVER_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
sed -i "s/\$RESOLVER_IP/${RESOLVER_IP}/g" /etc/nginx/conf.d/default.conf
sed -i "s/\$SERVICE_NAME/${SERVICE_NAME}/g" /etc/nginx/conf.d/default.conf


/bin/oauth2_proxy -set-xauthrequest --email-domain=${EMAIL_DOMAIN} -config=/etc/oauth2_proxy.cfg &
/usr/sbin/nginx -g 'daemon off;'
