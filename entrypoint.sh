#!/bin/bash

echo PASSWORD ${PASSWORD}
export PASSWORD_JSON="$(echo -n "$PASSWORD" | jq -Rc)"

export ENCRYPT="chacha20-ietf-poly1305"

echo QR_PATH ${QR_PATH}

echo V2_PATH ${V2_PATH}

export DOMAIN="$APP_NAME.herokuapp.com"
echo DOMAIn ${DOMAIN}

bash /conf/shadowsocks-libev_config.json >/etc/shadowsocks-libev/config.json
echo /etc/shadowsocks-libev/config.json
cat /etc/shadowsocks-libev/config.json

bash /conf/nginx_ss.conf >/etc/nginx/conf.d/ss.conf
echo /etc/nginx/conf.d/ss.conf
cat /etc/nginx/conf.d/ss.conf

[ ! -d /wwwroot/${QR_PATH} ] && mkdir /wwwroot/${QR_PATH}
plugin=$(echo -n "v2ray;path=/${V2_PATH};host=${DOMAIN};tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
ss="ss://$(echo -n ${ENCRYPT}:${PASSWORD} | base64 -w 0)@${DOMAIN}:443?plugin=${plugin}"
echo "${ss}" | tr -d '\n' >/wwwroot/${QR_PATH}/index.html
echo -n "${ss}" | qrencode -s 6 -o /wwwroot/${QR_PATH}/vpn.png

ss-server -c /etc/shadowsocks-libev/config.json &
rm -rf /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'
