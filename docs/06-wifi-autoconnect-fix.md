# Step 06 — Fix Wi-Fi Autoconnect on Boot

After aggressive cleanup, Wi-Fi may stop connecting automatically.

## Ensure NetworkManager is enabled

sudo systemctl enable NetworkManager.service

## Mark Wi-Fi connection as autoconnect

List connections:

nmcli connection show

Set autoconnect:

nmcli connection modify <connection-name> connection.autoconnect yes

## Disable conflicting services

Ensure iwd is not fighting NetworkManager:

sudo systemctl disable iwd.service

Reboot and verify Wi-Fi connects automatically.
