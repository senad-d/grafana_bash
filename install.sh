#!/bin/bash

#SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
apt update
clear

bash ./bash/docker_install.sh &> /dev/null
#echo
#echo "Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker). Docker system prune automated."
#echo
#echo "$SPLIT"
touch /home/"${SUDO_USER:-$USER}"/docker/.env
bash ./bash/fn_var.sh
#echo
#echo "Created docker .env"
#echo
#echo "$SPLIT"
bash ./bash/data_dash.sh &> /dev/null
cp ./json/* /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards/
bash ./bash/docker_compose.sh
#echo "$SPLIT"
#echo "Created docker-comose.yml with:"
#echo 
#echo "Grafana..........(analytics & monitoring solution)"
#echo "InfluxDB.........(high-speed read and write database)"
#echo "Telegraf.........(plugin-driven server agent for collecting and reporting metrics)"
#echo ""
#rm /home/"${SUDO_USER:-$USER}"/docker/.var