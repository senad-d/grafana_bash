#!/bin/bash

SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
clear
echo "$SPLIT"
echo
echo "Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker)."
echo
echo "$SPLIT"
mkdir -p /home/"${SUDO_USER:-$USER}"/docker/grafana
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