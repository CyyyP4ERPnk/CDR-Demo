
################### X-PAC SECURITY FEATURES #######################
gsutil cp "my-gcs-bucket-with-elastic-certificates" /etc/elasticsearch
gsutil cp "${ca_bucket}http.p12" /etc/elasticsearch
chmod 777 /etc/elasticsearch
cat <<EOT >> /etc/elasticsearch/elasticsearch.yml
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: /etc/elasticsearch/http.p12
xpack.security.http.ssl.keystore.secure_password: ''
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.audit.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: /etc/elasticsearch/elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: /etc/elasticsearch/elastic-certificates.p12
EOT
echo "${elastic_pw}" | sudo ./bin/elasticsearch-keystore add -xf bootstrap.password
systemctl restart elasticsearch.service