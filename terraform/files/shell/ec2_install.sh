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
# instalando o git:
apt install git -y;

# criando pasta main:
mkdir -p "$APP_DIR";
chown -R $APP_USER:$APP_USER "/home/$APP_USER";

echo "Script finalizado";
