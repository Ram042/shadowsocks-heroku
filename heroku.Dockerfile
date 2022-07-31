FROM docker.io/library/ubuntu

RUN export DEBIAN_FRONTEND=noninteractive && set -ex \
    && apt-get update && apt-get upgrade -y \
    && apt-get install gnupg curl -y \
    && curl https://cli-assets.heroku.com/install.sh | sh

CMD bash