########################### HEARTBEAT ##################################

sudo heartbeat keystore create
echo "${elastic_pw}" | sudo bin/heartbeat keystore add ES_PASSWORD


cat <<EOT >> /etc/heartbeat/heartbeat.yml
output.elasticsearch:
hosts: ['https://${elastic_host_1}:9200','https://${elastic_host_2}:9200','https://${elastic_host_3}:9200']
username: 'elastic'
password: '${ES_PASSWORD}'
protocol: 'https'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
setup.kibana:
host: '0.0.0.0:8080'
username: 'elastic'
password: '${ES_PASSWORD}'
# Add monitors
heartbeat.monitors:
- type: http
urls: ['https://${elastic_host_1}:9200']
username: elastic
password: '${ES_PASSWORD}'
schedule: '@every 10s'
name: 'my-elastic-instance-1'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
- type: http
urls: ['https://${elastic_host_2}:9200']
username: elastic
password: '${ES_PASSWORD}'
schedule: '@every 10s'
name: 'my-elastic-instance-2'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
- type: http
urls: ['https://${elastic_host_3}:9200']
username: elastic
password: '${ES_PASSWORD}'
schedule: '@every 10s'
name: 'my-elastic-instance-3'
ssl:
certificate_authorities: ['/etc/kibana/elasticsearch-ca.pem']
verification_mode: 'none'
setup.ilm.overwrite: true
processors:
- add_observer_metadata:
cache.ttl: 5m
EOT
cd /usr/share/heartbeat
sudo heartbeat setup
sudo service heartbeat-elastic start