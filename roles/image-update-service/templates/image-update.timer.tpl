[Unit]
Description=Runs {{ service_name }}-image-update every {{ frequency }}
Requires={{ service_name }}-image-update.service

[Timer]
Unit={{ service_name }}-image-update.service
OnUnitActiveSec={{ frequency }}

[Install]
WantedBy=timers.target
