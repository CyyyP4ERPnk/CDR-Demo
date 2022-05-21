####################### KEYSTORE ################################
cd /usr/share/kibana
sudo bin/kibana-keystore create
echo "${elastic_pw}" | sudo bin/kibana-keystore add elasticsearch.password