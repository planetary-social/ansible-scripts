[Unit]
Description=Run nos-health-check: adds status from {{ health_check_endpoint }}
Wants=nos-health-check.timer

[Service]
ExecStart=/usr/local/bin/nos-health-check.sh

[Install]
WantedBy=multi-user.target
