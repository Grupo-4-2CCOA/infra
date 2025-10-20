mkdir /home/ubuntu/frontend
chown ubuntu:ubuntu /home/ubuntu/frontend
echo "<h1>NGINX via Docker Compose!</h1>" > /home/ubuntu/frontend/index.html
echo "Página inicial do nginx criada com sucesso."

sudo docker compose -f /home/ubuntu/compose.yaml up -d
echo "NGINX iniciado com sucesso."

