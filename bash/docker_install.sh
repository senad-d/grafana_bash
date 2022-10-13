#!/bin/bash

apt update
apt install docker.io -y
apt install docker-compose -y
mkdir -p /home/"${SUDO_USER:-$USER}"/docker/grafana
groupadd --system dockergroup
useradd --system --no-create-home --group dockergroup,"${SUDO_USER:-$USER}" -s /bin/false docker
chown -R "${SUDO_USER:-$USER}":docker /home/"${SUDO_USER:-$USER}"/docker
usermod -aG docker,adm "${SUDO_USER:-$USER}"