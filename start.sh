#!/bin/bash

SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
clear
echo "$SPLIT"
yum install docker -y
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir -p /home/"${SUDO_USER:-$USER}"/docker/grafana
usermod -a -G docker "${SUDO_USER:-$USER}"
newgrp docker
chown -R "${SUDO_USER:-$USER}":docker /home/"${SUDO_USER:-$USER}"/docker
systemctl enable docker.service
systemctl start docker.service
echo
echo "Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker)."
echo
echo "$SPLIT"
touch /home/"${SUDO_USER:-$USER}"/docker/.env
bash ./bash/fn_var.sh
echo
echo "Created docker .env"
echo
bash ./bash/data_dash.sh &> /dev/null
cp ./dash_temp/* /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards/
cp ./telegraf.conf /home/"${SUDO_USER:-$USER}"/docker/telegraf.conf
bash ./bash/docker_compose.sh
echo "$SPLIT"
echo "Created docker-comose.yml with:"
echo 
echo "Grafana..........(analytics & monitoring solution)"
echo "InfluxDB.........(high-speed read and write database)"
echo "Telegraf.........(plugin-driven server agent for collecting and reporting metrics)"
echo 
echo "$SPLIT"