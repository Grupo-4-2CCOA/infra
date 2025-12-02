mkdir /home/ubuntu/frontend
mkdir /home/ubuntu/nginx
chown ubuntu:ubuntu /home/ubuntu/frontend
echo "<h1>NGINX via Docker Compose!</h1>" > /home/ubuntu/frontend/index.html
cat << 'EOF' > /home/ubuntu/nginx/default.conf
server {
    listen 80;
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF
echo "Página inicial do nginx criada com sucesso."

