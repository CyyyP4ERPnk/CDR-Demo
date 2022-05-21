############### CERTIFICATES FOR KIBANA ##############
gsutil cp "${ca_bucket}http.p12" /etc/kibana
gsutil cp "${ca_bucket}elasticsearch-ca.pem" /etc/kibana
chmod 777 /etc/kibana/http.p12
chmod 777 /etc/kibana/elasticsearch-ca.pem
chmod 777 /etc/ssl/certs/elasticsearch-ca.pem
cp /etc/kibana/elasticsearch-ca.pem /etc/ssl/certs
touch /var/log/kibana.log
sudo chmod 777 /var/log/kibana.log