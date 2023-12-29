[Unit]
Description=Run {{ service_name }}-image-update: check for new image, restarting service if found.
Wants={{ service_name }}-image-update.timer

[Service]
ExecStart=/usr/local/bin/{{ service_name }}-image-update.sh
WorkingDirectory={{ working_dir }}

[Install]
WantedBy=multi-user.target
