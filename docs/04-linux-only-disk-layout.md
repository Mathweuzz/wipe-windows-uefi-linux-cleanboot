# Step 04 — Disable Unnecessary Services

This step focuses on disabling services that commonly slow down boot time on Linux systems,
especially after migrating from a dual-boot or Windows environment.

The goal is to reduce boot time **without breaking networking, graphics, or login**.

## Check current boot delays

Run:

systemd-analyze
systemd-analyze blame

Pay attention to:
- plymouth-quit-wait.service
- NetworkManager-wait-online.service
- ModemManager.service
- avahi-daemon.service
- docker.service

## Disable services you do not need

### Disable NetworkManager wait-online
This service is not required for desktop usage.

sudo systemctl disable NetworkManager-wait-online.service

### Disable ModemManager (if you do not use mobile broadband)

sudo systemctl disable ModemManager.service

### Disable Avahi (local network discovery)

sudo systemctl disable avahi-daemon.service
sudo systemctl disable avahi-daemon.socket

### Disable Docker (if not used daily)

sudo systemctl disable docker.service
sudo systemctl disable docker.socket

## Re-check boot time

Reboot and run:

systemd-analyze

Boot time should already be noticeably reduced.