[Unit]
Description=Run nostrface-image-update: check for new image, restarting service if found.
Wants=nostrface-image-update.timer

[Service]
ExecStart=/usr/local/bin/nostrface-image-update.sh
WorkingDirectory={{ homedir }}/services/nostrface

[Install]
WantedBy=multi-user.target
