[Unit]
Description=Run sentry-status-check: adds status from {{ inventory_hostname }}/_health to prom metrics
Wants=sentry-status-check.timer

[Service]
ExecStart=/usr/local/bin/sentry-status-check.sh

[Install]
WantedBy=multi-user.target