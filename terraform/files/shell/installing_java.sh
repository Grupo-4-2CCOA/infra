sudo mkdir /home/ubuntu/backend
sudo mkdir /usr/share/api
sudo chown ubuntu:ubuntu /usr/share/api
echo "Diretório /usr/share/api criado com sucesso."

cat <<EOF > /home/ubuntu/compose.yaml
${arquivo_docker_compose}
EOF