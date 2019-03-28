#!/bin/bash
cat <<EOF > /etc/systemd/system/puma.service
[Unit]
Description=Puma HTTP Server
After=network.target
[Service]
Type=simple
User=1
WorkingDirectory=/home/1/reddit
ExecStart=/usr/local/bin/puma
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable puma.service
