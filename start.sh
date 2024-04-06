wget https://raw.githubusercontent.com/ivanovsergey93/availup/main/availup.sh
chmod +x availup.sh
./availup.sh

sudo tee /etc/systemd/system/avail.service > /dev/null <<EOF
[Unit]
Description=avail Daemon
After=network-online.target
[Service]
User=$USER
ExecStart=/root/.avail/bin/avail-light --config /root/.avail/config/config.yml --app-id 0 --identity /root/.avail/identity/identity.toml --network goldberg
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable avail
sudo systemctl start avail

sleep 5

# sudo journalctl -f -u avail
journalctl -u avail | grep -m 1 "public key"
cat .avail/identity/identity.toml   