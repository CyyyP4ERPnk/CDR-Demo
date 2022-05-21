####### APPEND TO ELASTICSEARCH CONFIGURATION FILE  ########
echo "node.name: ${node_name}" >> /etc/elasticsearch/elasticsearch.yml
echo "network.host : 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
echo "discovery.seed_hosts:" >> /etc/elasticsearch/elasticsearch.yml
echo " - ${elastic_host_1}" >> /etc/elasticsearch/elasticsearch.yml
echo " - ${elastic_host_2}" >> /etc/elasticsearch/elasticsearch.yml
echo " - ${elastic_host_3}" >> /etc/elasticsearch/elasticsearch.yml
echo "cluster.name: elasticsearch" >> /etc/elasticsearch/elasticsearch.yml
echo "cluster.initial_master_nodes:" >> /etc/elasticsearch/elasticsearch.yml
echo " - ${master_node}" >> /etc/elasticsearch/elasticsearch.yml