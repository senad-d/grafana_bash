#!/bin/bash

USER=${SUDO_USER:-$USER}
PUID=$(id -u "${SUDO_USER:-$USER}")
PGID=$(id -g "${SUDO_USER:-$USER}")
IP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/.env
USER=${USER}
PUID=${PUID}
PGID=${PGID}

#ADDED
EOF