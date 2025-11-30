sudo mkdir -p /home/ubuntu/backend /usr/share/api /usr/share/consumer
sudo chown ubuntu:ubuntu /home/ubuntu/backend
sudo chown ubuntu:ubuntu /usr/share/api
sudo chown ubuntu:ubuntu /usr/share/consumer
echo "Diretórios criados com sucesso."

cat <<EOF > /home/ubuntu/compose.yaml
${arquivo_docker_compose}
EOF