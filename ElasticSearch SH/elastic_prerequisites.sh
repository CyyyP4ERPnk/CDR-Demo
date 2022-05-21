################### INSTALL PREREQUISITIES  #####################
sudo apt update
sudo apt -y install default-jre curl jq
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt -y install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt -y install elasticsearch