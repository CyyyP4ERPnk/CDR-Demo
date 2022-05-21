################ LOGSTASH ##############################
sudo systemctl enable logstash
sudo systemctl start logstash
sudo /usr/share/logstash/bin/logstash-plugin install x-pack
sudo bin/logstash-keystore create
echo "${elastic_pw}" | sudo bin/logstash-keystore add ES_PASSWORD


cat <<EOT >> /etc/logstash/logstash.yml
xpack.monitoring.enabled: true
xpack.monitoring.elasticsearch.url: 'https://${internal_lb_ip}:9200'
xpack.monitoring.elasticsearch.username: 'elastic'
# read password from logstash.keystore
xpack.monitoring.elasticsearch.password: '${ES_PASSWORD}'
xpack.monitoring.elasticsearch.ssl.certificate_authority: /etc/kibana/elasticsearch-ca.pem
xpack.monitoring.elasticsearch.ssl.verification_mode: 'none'
output {
  elasticsearch {
    hosts: ['https://${elastic_host_1}:9200','https://${elastic_host_2}:9200','https://${elastic_host_3}:9200']
    user: 'elastic'
    password: '${ES_PASSWORD}' 
  }
}
EOT