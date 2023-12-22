[Unit]
Description=Runs sentry-status-check every minute
Requires=sentry-status-check.service

[Timer]
Unit=sentry-status-check.service
OnUnitActiveSec=1m

[Install]
WantedBy=timers.target