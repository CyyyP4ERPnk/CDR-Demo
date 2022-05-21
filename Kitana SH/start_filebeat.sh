################## START FILEBEAT  #######################
sudo systemctl daemon-reload
sudo systemctl enable filebeat
sudo filebeat modules enable system nginx mysql elasticsearch kibana googlecloud
cd /etc/filebeat/
sudo filebeat setup -e
sudo systemctl start filebeat