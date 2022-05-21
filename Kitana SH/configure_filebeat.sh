################## CONFIGURE FILEBEAT #######################
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-x.x.x-amd64.deb // Replace x.x.x with version
sudo dpkg -i filebeat-x.x.x-amd64.deb  // Replace x.x.x with version
sudo filebeat keystore create
echo "${elastic_pw}" | sudo bin/filebeat keystore add ES_PASSWORD

cat <<EOT >> /etc/filebeat/filebeat.yml
output.elasticsearch:
hosts: ['https://${internal_lb_ip}:9200']
username: "elastic"
password: "${ES_PASSWORD}"
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
setup.kibana:
host: "0.0.0.0:8080"
username: "elastic"
password: "${ES_PASSWORD}"
filebeat.inputs:
- type: log
enabled: true
paths:
- /var/log/*.log
EOT