[Unit]
Description=Run notifications-image-update: check for new image, restarting service if found.
Wants=notifications-image-update.timer

[Service]
ExecStart=/usr/local/bin/notifications-image-update.sh
WorkingDirectory=/home/{{ admin_username }}/notifications

[Install]
WantedBy=multi-user.target
