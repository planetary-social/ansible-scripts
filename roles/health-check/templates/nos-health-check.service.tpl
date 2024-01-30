[Unit]
Description=Run nos-health-check: adds health metric using output of /usr/local/bin/nos-health-check.sh
Wants=nos-health-check.timer

[Service]
ExecStart=/usr/local/bin/nos-health-check.sh

[Install]
WantedBy=multi-user.target
