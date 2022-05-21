############## APPEND TO KIBANA CONFIGURATION FILE ############
cat <<EOT >> /etc/kibana/kibana.yml
elasticsearch.hosts: ['https://${internal_lb_ip}:9200']
server.name: my-elastic-kibana
server.host: 0.0.0.0
server.port: 8080
kibana.index: .kibanana
logging.dest: /var/log/kibana.log
logging.verbose: true
csp.strict: true
elasticsearch.username: 'elastic'
xpack.security.encryptionKey: 'akey'
xpack.security.audit.enabled: true
xpack.encryptedSavedObjects.encryptionKey: 'akey'
server.ssl.keystore.path: '/etc/kibana/http.p12'
server.ssl.keystore.password: ''
elasticsearch.ssl.certificateAuthorities: ['/etc/kibana/elasticsearch-ca.pem']
elasticsearch.ssl.verificationMode: 'none'
server.ssl.enabled: true
EOT