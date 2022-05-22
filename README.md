# CDR-Demo

OBJECTIVE

The objective is to create a GPC-managed ElasticSearch in a VPC. 
Our Nginx server container image will be deployed behind a Cloud Load Balancer. Our container logs & access logs are going to be configured to go to ElasticSearch.
We'll be using Terraform to build as much of the infrastructure for this cloud environment as possible.

Our VM is going to have its own subnet. 
We'll also make sure the VM hosting ElasticSearch has a service account with minimal required rights.

**This will allow any user who needs to utilize ElasticSearch to do so in a manner controlling the scope of their influence on the service.
Because the VMs don’t have an external IP, the internet isn't accessible to download software. A solution to this is to open a NAT gateway with a router to be able to download anything from the internet. After the software is installed, the NAT gateway can be removed.**

###########################################################################################################

NETWORKING

In GCP, if you want to access your VPC network from Google App Engine or Cloud functions, a VPC connector is required. We'll host an API on Google App Engine that invokes Elasticsearch internal load balancer via the VPC connector.

Elasticsearch clusters with more than 1 node require a load balancer to distribute the requests. Putting the VMs behind a load balancer requires you to create instance groups. 

**To achieve redundancy for the application, best practice is to put the VMs in the same region, speading VM instances in different zones. In the event of a problem in one zone, the others won’t be affected and provide application resilience and redundancy.** 

In this example we’re deploying three VMs, my-elastic-instance-1 and 2 are in zone d, while my-elastic-instance-3 is in zone c.

Since we also want to access Kibana through a load balancer, we’ll create an instance group for that too.

You configure your load balancer with health-checks and forwarding rules. // REVISIT TO ADD MORE INFO

**It's important to also create firewall rules. We want to allow internal communication between the nodes in the subnet, allowing load balancer and health checks to communicate with the VMs, but also make sure to block out unwanted traffic.**

###########################################################################################################

ELASTICSEARCH

Google Cloud Storage Buckets were made manually, as well as the certificates to securely transfer information using ElasticSearch. 
Steps for manually creating each are detailed in their respective .txt files.
**Make sure to place your certificate inside of the Google Cloud Storage bucket that you create. After you finish with this step, proceed with the rest of the setup.**

Conduct a startup test for Elasticsearch by checking if the credentials.json file is present or not. This allows us to only run the startup script once, not every time we restart the machine. If the file is present we exit the script. "startup_check"

You'll then download and install the prerequisites to run Elasticsearch. "elastic_prerequisites.sh"

Next, you'll need to configure Elasticsearch in the elasticsearch.yml file. At this step, you are setting the IPs of the nodes and deciding which one is the master node. "elasticsearch_yaml"

***Be mindful of the input variables in the start-up script; they were assigned and can be referenced in "startup_input_var".*** 

Part of configuring Elasticsearch is setting aside RAM for Heap-Size. In this case, the heap-size is set to 50% of total RAM and below 32 GB. "jvm_ram.sh"

The next step will require you to install the necessary plugin needed to use GCS as a backup for all our Elasticsearch indices. In addition, this also adds the service account key to the Keystore and restarts Elasticsearch. "gcs_plugin_sa"

The next command enables X-Pack monitoring in the cluster settings. "xpac_monitoring.sh"


###########################################################################################################

KIBANA
