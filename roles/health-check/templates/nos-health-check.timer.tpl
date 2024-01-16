[Unit]
Description=Runs nos-health-check every minute
Requires=nos-health-check.service

[Timer]
Unit=nos-health-check.service
OnUnitActiveSec=1m

[Install]
WantedBy=timers.target
