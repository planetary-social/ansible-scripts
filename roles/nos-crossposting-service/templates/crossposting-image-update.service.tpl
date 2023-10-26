[Unit]
Description=Run crossposting-image-update: check for new image, restarting service if found.
Wants=crossposting-image-update.timer

[Service]
ExecStart=/usr/local/bin/crossposting-image-update.sh
WorkingDirectory={{ homedir }}/crossposting

[Install]
WantedBy=multi-user.target
