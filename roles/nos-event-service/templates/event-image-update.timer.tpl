[Unit]
Description=Runs event-image-update every 3 minutes
Requires=event-image-update.service

[Timer]
Unit=event-image-update.service
OnUnitActiveSec=3m

[Install]
WantedBy=timers.target
