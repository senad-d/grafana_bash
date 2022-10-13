#!/bin/bash

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/docker-compose.yml
version: "3.9"
services:
  db:
    image: influxdb:1.7.8
    container_name: influxdb
    ports:
      - 8086:8086
    environment:
      - INFLUXDB_DB=telegraf

  telegraf:
    image: telegraf
    env_file: .env
    volumes:
      - ./telegraf.conf:/etc/telegraf/telegraf.conf:ro
    depends_on:
      - db
    environment:
      - INFLUXDB_URL=http://influxdb:8086
      - WEBSITE=${WEBSITE}
    network_mode: "service:db"

  grafana:
    image: grafana/grafana:5.4.2
    container_name: grafana
    ports:
      - 3000:3000
    volumes:
      - grafana-data:/var/lib/grafana
      - ./grafana:/etc/grafana/provisioning
    restart: unless-stopped

volumes:
  grafana-data:
    driver: local
EOF

docker-compose -f /home/"${SUDO_USER:-$USER}"/docker/docker-compose.yml --env-file /home/"${SUDO_USER:-$USER}"/docker/.env up -d