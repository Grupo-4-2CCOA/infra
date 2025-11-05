sudo mkdir /home/ubuntu/backend
sudo mkdir /usr/share/api
sudo chown ubuntu:ubuntu /usr/share/api
echo "Diretório /usr/share/api criado com sucesso."

echo "${arquivo_docker_compose}" | base64 -d > /home/ubuntu/compose.yaml

sudo docker compose -f /home/ubuntu/compose.yaml up -d
echo "API iniciada com sucesso."