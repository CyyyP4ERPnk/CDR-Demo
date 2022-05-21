
################### INSTALL METRICSBEAT ######################
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo 'deb https://artifacts.elastic.co/packages/oss-6.x/apt stable main' | sudo tee /etc/apt/sources.list.d/beats.list
sudo apt-get update && sudo apt-get install metricbeat
sudo metricbeat keystore create
echo "${elastic_pw}" | sudo bin/metricbeat-keystore add ES_PASSWORD

# echo "setup.dashboards.enabled: true" >> /etc/metricbeat/metricbeat.yml
cat <<EOT >> /etc/metricbeat/metricbeat.yml
output.elasticsearch:
hosts: ['https://${internal_lb_ip}:9200']
username: 'elastic'
password: '${ES_PASSWORD}'
protocol: 'http'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
setup.kibana:
host: '0.0.0.0:8080'
username: 'elastic'
password: '${ES_PASSWORD}'
EOT

sudo systemctl enable metricbeat
sudo systemctl start metricbeat
cd /etc/metricbeat
sudo metricbeat modules enable elasticsearch-xpack

cat <<EOT >> /etc/metricbeat/modules.d/elasticsearch-xpack.yml
hosts: ['https://${internal_lb_ip}:9200']
username: 'elastic'
password: '${ES_PASSWORD}'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
EOT
sudo systemctl restart kibana.service