#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run install.sh as root (sudo ./install.sh)"
  exit 1
fi

echo "[*] Installing omniboost to /usr/local/bin/omniboost..."
install -m 755 omniboost /usr/local/bin/omniboost

echo "[*] Installing systemd service..."
install -m 644 omniboost.service /etc/systemd/system/omniboost.service
systemctl daemon-reload
systemctl enable omniboost.service

echo "[✓] OmniBoost successfully installed! Run 'omniboost' to start."
