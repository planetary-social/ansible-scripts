# Recommended config pulled from Digital Ocean: 
# https://www.digitalocean.com/community/developer-center/how-to-install-loki-stack-in-doks-cluster#step-5-setting-persistent-storage-for-loki

auth_enabled: false

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
  - from: 2020-05-15
    store: tsdb
    object_store: s3
    schema: v13
    index:
      prefix: index_
      period: 24h

storage_config:
  tsdb_shipper:
    active_index_directory: /loki/index
    cache_location: /loki/index_cache
  aws:
    bucketnames: {{ do_spaces_bucket_name }}
    endpoint: {{ do_spaces_bucket_endpoint }}
    region: {{ do_spaces_bucket_region }}
    access_key_id: {{ do_spaces_access_key }}
    secret_access_key: {{ do_spaces_secret_key }}
    s3forcepathstyle: true