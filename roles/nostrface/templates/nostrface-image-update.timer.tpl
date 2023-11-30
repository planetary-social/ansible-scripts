[Unit]
Description=Runs nostrface-image-update every 3 minutes
Requires=nostrface-image-update.service

[Timer]
Unit=nostrface-image-update.service
OnUnitActiveSec=3m

[Install]
WantedBy=timers.target
