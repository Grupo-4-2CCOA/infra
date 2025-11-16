#!/bin/bash
# Script para instalar Docker e docker compose no Ubuntu

set -e

echo "Iniciando a instalação do Docker no Ubuntu Linux..."

# Atualizando a lista de pacotes
sudo apt update
echo "Lista de pacotes atualizada com sucesso."

# Instalando o Docker
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
echo "Dependências do Docker instaladas com sucesso."

# Adicionando a chave GPG oficial do Docker
curl -4fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Chave GPG do Docker adicionada com sucesso."

# Adicionando o repositório do Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Repositório do Docker adicionado com sucesso."

# Atualizando novamente e instalando o Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
echo "Docker instalado com sucesso."

# Habilitando e iniciando o Docker
sudo systemctl enable docker
echo "Docker habilitado para iniciar na inicialização."

sudo systemctl start docker
echo "Docker iniciado com sucesso."

# Adicionando o usuário ubuntu ao grupo docker
sudo usermod -aG docker ubuntu
echo "Usuário ubuntu adicionado ao grupo docker."

# Instalando o Docker Compose
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins

sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/local/bin/docker-compose
echo "Docker Compose baixado com sucesso..."

sudo chmod +x /usr/local/bin/docker-compose
echo "Permissões do Docker Compose ajustadas com sucesso..."

# echo "Instalando AWS CLI..."
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# sudo apt install -y unzip
# unzip awscliv2.zip
# sudo ./aws/install

# Criando link simbólico para o Docker Compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose