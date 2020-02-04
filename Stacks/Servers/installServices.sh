#!/usr/bin/env bash
PROJECT_PATH=${PROJECT_PATH:-/root/Docker-Services}
SERVICE_PATH=${SERVICE_PATH:-/etc/systemd/system/sshd.service}

echo "Starting the installer for docker backed OpenSSH Server."

echo "Downloading the 'sshd.service' file from the repo to '${SERVICE_PATH}'"
wget -O "${SERVICE_PATH}" https://raw.githubusercontent.com/K-FOSS/Docker/master/Stacks/Servers/systemd/sshd.service

echo "Starting & enabling new SSHD Service"
systemctl enable sshd.service
systemctl start sshd.service

echo "Creating '${PROJECT_PATH}'"
mkdir ${PROJECT_PATH}

echo "Downloading the VM 'docker-compose.yml' file from the repo to '${PROJECT_PATH}'"
wget -O "${PROJECT_PATH}/docker-compose.yml" https://raw.githubusercontent.com/K-FOSS/Docker/master/Stacks/Servers/docker-compose.yml

echo "Server services 'docker-compose.yml' has been downloaded. Up to you to bring the stack up."
