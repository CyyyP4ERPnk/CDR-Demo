################### REGISTER BACKUP REPOSITORY ###################
curl -X PUT "https://elastic:${elastic_pw}@0.0.0.0:9200/_snapshot/backup?pretty" -k -H 'Content-Type: application/json' -d '{"type": "gcs","settings": {"bucket": "${backup_bucket}","service_account": "/usr/share/credentials.json"}}'
############ CREATE BACKUP POLICY FOR DAILY SNAPSHOTS ##############
curl -X PUT -k "https://elastic:${elastic_pw}@0.0.0.0:9200/_slm/policy/nightly-snapshots?pretty" -H 'Content-Type: application/json' -d'{ "schedule": "0 30 1 * * ?", "name": "elastic-snapshot", "repository": "backup", "config": {"indices": ["*"]}, "retention": {"expire_after": "30d", "min_count": 5, "max_count": 30 }}'
################### CREATE CUSTOM ROLES ##########################
curl -X PUT -k "https://elastic:${elastic_pw}@0.0.0.0:9200/_security/role/API" -H 'Content-Type: application/json' -d '{ "indices": [{ "names": [ "*-read-alias", "*-write-alias"], "privileges": ["read"] } ]}'
curl -X PUT -k "https://elastic:${elastic_pw}@0.0.0.0:9200/_security/role/Cloud_function" -H 'Content-Type: application/json' -d '{ "indices": [{ "names": [ "*-read-alias", "*-write-alias"], "privileges": ["read", "create", "create_doc", "create_index", "index", "delete", "write", "view_index_metadata" ] } ]}'
################## ADD ANY SETTINGS YOU LIKE #####################