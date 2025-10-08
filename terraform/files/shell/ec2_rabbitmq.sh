#!/bin/bash

echo "Script iniciando";

APP_USER="ubuntu";
APP_DIR="/home/$APP_USER/main";

# instalando docker:
apt update && apt upgrade -y;

apt install ca-certificates curl -y;
install -m 0755 -d /etc/apt/keyrings;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc;
chmod a+r /etc/apt/keyrings/docker.asc;
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null;
apt update;

apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y;

usermod -aG docker $APP_USER;
apt update;

cat <<EOF > docker-compose-rabbitmq.yaml
version: '3.8'
services:
  rabbitmq:
    image: 'rabbitmq:3.13-management'
    environment:
      - RABBITMQ_DEFAULT_USER=myuser
      - RABBITMQ_DEFAULT_PASS=secret
    ports:
      - '5672:5672'
      - '15672:15672'
EOF

# Subir RabbitMQ via Docker Compose
sudo docker compose up;

echo "Script finalizado";
