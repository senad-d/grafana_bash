#!/bin/bash

SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)

fn_website() { echo;
while true; do
        read -r -p "Do you wish to run WebSite?
Yes | No --> " yn
        case $yn in
            [Yy]* ) echo;
                    echo "Enter domain name you want to use:";
                    read WEBSITE;
                    echo "WEBSITE=${WEBSITE}" >> /home/"${SUDO_USER:-$USER}"/docker/.env;
                    echo;
                    echo "Domain name set as ${WEBSITE}";
                    echo;
                    echo "$SPLIT";
                    fn_bye;;
            [Nn]* ) fn_bye;;
            * ) echo "Please answer yes or no.";;
          esac
done }

fn_bye() { echo "Done with custom variables"; exit 0; }
echo "$SPLIT";

fn_website