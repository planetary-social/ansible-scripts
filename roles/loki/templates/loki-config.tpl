# Recommended config pulled from Digital Ocean: 
# https://www.digitalocean.com/community/developer-center/how-to-install-loki-stack-in-doks-cluster#step-5-setting-persistent-storage-for-loki

auth_enabled: false  # TODO: We'll want auth of some sort here.

server:
  http_listen_port: 3100

common:
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory
  replication_factor: 1
  path_prefix: /loki

schema_config:
  configs:
  - from: '2020-10-24'
    store: boltdb-shipper
    object_store: aws
    schema: v11
    index:
      prefix: index_
      period: 24h

storage_config:
  boltdb_shipper:
    active_index_directory: /data/loki/boltdb-shipper-active
    cache_location: /data/loki/boltdb-shipper-cache
    cache_ttl: 24h
    shared_store: aws
  aws:
    bucketnames: {{ do_spaces_bucket_name }}
    endpoint: {{ do_spaces_bucket_endpoint }}
    region: {{ do_spaces_bucket_region }}
    access_key_id: {{ do_spaces_access_key }}
    secret_access_key: {{ do_spaces_secret_key }}
    s3forcepathstyle: true