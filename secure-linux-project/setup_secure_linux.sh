#!/usr/bin/env bash
set -euo pipefail

GROUP="projshared"
PROJECT_DIR="/home/project"

echo "[1] Create group"
sudo groupadd -f "$GROUP"

echo "[2] Create secure directory"
sudo mkdir -p "$PROJECT_DIR"

echo "[3] Set ownership + permissions (setgid + sticky + 770)"
sudo chown root:"$GROUP" "$PROJECT_DIR"
sudo chmod 3770 "$PROJECT_DIR"

echo "[4] Install required packages"
sudo apt update
sudo apt install -y acl auditd apache2

echo "[5] Apply default ACL"
sudo setfacl -d -m g:"$GROUP":rx "$PROJECT_DIR"
sudo setfacl -m g:"$GROUP":rx "$PROJECT_DIR"

echo "[6] Enable auditd + add audit watch"
sudo systemctl enable --now auditd
sudo auditctl -w "$PROJECT_DIR" -p rwxa -k project_access || true

echo "[7] Publish audit log to Apache"
sudo ausearch -k project_access > /var/www/html/auditlog.txt || true
sudo systemctl enable --now apache2

echo "Done. Open: http://127.0.0.1/auditlog.txt"
