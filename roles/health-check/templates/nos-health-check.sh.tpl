#! /bin/bash

http_response=$({{ health_check_command }})
cat << EOF > /var/lib/node_exporter/textfile_collector/nos_health_check.prom
# HELP nos_health_check http status of pinging {{ health_check_endpoint }}
# TYPE nos_health_check gauge
nos_health_check $http_response
EOF
