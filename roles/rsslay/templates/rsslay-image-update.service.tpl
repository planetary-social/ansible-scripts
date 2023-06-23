[Unit]
Description=Run rsslay-image-update: check for new image, restarting service if found.
Wants=rsslay-image-update.timer

[Service]
ExecStart=/usr/local/bin/rsslay-image-update.sh
WorkingDirectory=/home/{{ admin_username }}/rsslay

[Install]
WantedBy=multi-user.target
