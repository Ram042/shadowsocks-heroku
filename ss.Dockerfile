FROM docker.io/library/ubuntu

ARG V2RAY_VERSION=v1.3.1

RUN export DEBIAN_FRONTEND=noninteractive && set -ex\
    && apt-get update -y \
    && apt-get install -y wget qrencode shadowsocks-libev nginx-light jq \
    && apt clean -y \
    && mkdir -p /etc/shadowsocks-libev /v2raybin /wwwroot \
    && wget -O- "https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_VERSION}.tar.gz" | \
    tar zx -C /v2raybin \
    && install /v2raybin/v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin \
    && rm -rf /v2raybin

ENV AppName=smart-sas

COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh

ENV PASSWORD=0123456789abcdef
ENV QR_PATH=0123456789abcdef
ENV V2_PATH=0123456789abcdef
ENV APP_NAME="<project name>"

CMD /entrypoint.sh
