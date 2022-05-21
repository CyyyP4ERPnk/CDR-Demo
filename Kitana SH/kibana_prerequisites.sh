############## INSTALL PREREQUISITIES #########################
sudo apt-get install openjdk-8-jre -y
sudo apt update
sudo apt install -y -qq apt-transport-https
sudo apt install -y fonts-liberation
sudo apt install -y libfontconfig1
sudo apt install -y logstash
sudo apt install -y snapd
sudo snap install micro - classic
cat <<EOT >> ~/.bashrc
export EDITOR='micro'
export VISUAL='micro'
EOT
sudo source ~/.bashrc
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install -y -qq kibana - allow-unauthenticated
curl -L -O https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-7.x.x-amd64.deb
sudo dpkg -i heartbeat-7.7.0-amd64.deb