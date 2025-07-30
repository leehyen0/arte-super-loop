#!/bin/bash
SERVICE_PATH="/etc/systemd/system/arte.service"

cat <<EOF > $SERVICE_PATH
[Unit]
Description=Arte Secure Loop
After=network.target

[Service]
ExecStart=/usr/bin/python3 -m uvicorn app.main:app --host 0.0.0.0 --port 8000
WorkingDirectory=$(pwd)
Restart=always
Environment=MODEL_KEY=this_is_a_32byte_secret_key_!
StandardOutput=append:$(pwd)/arte.log
StandardError=append:$(pwd)/arte.err

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable arte.service
systemctl restart arte.service
