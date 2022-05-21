##################### APM ##########################
curl -L -O https://artifacts.elastic.co/downloads/apm-server/apm-server-7.8.0-amd64.deb
sudo dpkg -i apm-server-7.7.0-amd64.deb

sudo apm-server keystore create
echo "${elastic_pw}" | sudo bin/apm-server keystore add ES_PASSWORD

cat <<EOT >> /etc/apm-server/apm-server.yml
output.elasticsearch:
hosts: ['https://${elastic_host_1}:9200','https://${elastic_host_2}:9200','https://${elastic_host_3}:9200']
username: 'elastic'
password: '${ES_PASSWORD}'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
apm-server:
host: 0.0.0.0:8081
EOT
sudo systemctl daemon-reload
sudo systemctl enable apm-server
sudo systemctl start apm-server