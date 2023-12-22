#! /bin/bash

http_response=$(curl -s -L -o /dev/null  -w "%{http_code}" http://{{ inventory_hostname }}/_health)
cat << EOF > /var/lib/node_exporter/textfile_collector/sentry_status_check.prom
# HELP sentry_status_check http status of pinging {{ inventory_hostname }}/_status.
# TYPE sentry_status_check gauge
sentry_status_check $http_response
EOF