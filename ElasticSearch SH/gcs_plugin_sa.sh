####### PLUGIN, SERVICE-ACCOUNT AND RESTART ELASTICSEARCH ########
systemctl enable elasticsearch.service
cd /usr/share/elasticsearch
sudo ./bin/elasticsearch-plugin install repository-gcs -b
echo ${gcp_sa} | base64 -d > credentials.json
sudo ./bin/elasticsearch-keystore add-file gcs.client.default.credentials_file credentials.json -s
systemctl restart elasticsearch.service