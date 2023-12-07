[Unit]
Description=Run event-image-update: check for new image, restarting service if found.
Wants=event-image-update.timer

[Service]
ExecStart=/usr/local/bin/event-image-update.sh
WorkingDirectory={{ homedir }}/services/events

[Install]
WantedBy=multi-user.target
