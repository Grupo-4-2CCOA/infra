sudo apt update -y
curl -fsSL https://deb.nodesource.com/setup_22.11.0 | sudo -E bash -
sudo apt install nodejs
sudo apt install npm

sudo apt install git
git clone https://github.com/Grupo-4-2CCOA/frontend.git

cd frontend
npm install
npm start