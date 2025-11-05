sudo apt install mysql-server -y
sudo systemctl stop mysql
sudo systemctl disable mysql

sudo mkdir /home/ubuntu/database
sudo mkdir /usr/share/mysql-beauty-barreto
sudo chown ubuntu:ubuntu /usr/share/mysql-beauty-barreto
echo "Diretório /usr/share/mysql-beauty-barreto criado com sucesso."

echo "${arquivo_docker_compose}" | base64 -d > /home/ubuntu/compose.yaml

sudo docker compose -f /home/ubuntu/compose.yaml up -d
echo "MySQL Server iniciado com sucesso."