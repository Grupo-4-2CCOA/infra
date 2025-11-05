#!/bin/bash
set -e

echo "Instalando Grafana..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates wget gnupg
sudo install -m 0755 -d /etc/apt/keyrings
wget -qO- https://packages.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/grafana.gpg
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list > /dev/null
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl daemon-reload
sudo systemctl enable --now grafana-server
sudo systemctl --no-pager --full status grafana-server || true
sudo ss -tulpen | grep ':3000' || true
echo "Grafana instalado e iniciado com sucesso."