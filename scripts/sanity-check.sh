#!/usr/bin/env bash
set -euo pipefail

error() {
  echo "ERROR: $1"
  exit 1
}

echo "Running system sanity check..."
echo

# Root filesystem
ROOT_SRC=$(findmnt -n -o SOURCE /)
[[ -n "$ROOT_SRC" ]] || error "Root filesystem not detected"

echo "Root filesystem: $ROOT_SRC"

# EFI
if [[ ! -d /boot/efi ]]; then
  error "/boot/efi does not exist"
fi

if ! mountpoint -q /boot/efi; then
  error "/boot/efi is not mounted"
fi

echo "EFI partition mounted."

# EFI entries
efibootmgr >/dev/null || error "efibootmgr failed"

# NetworkManager
systemctl is-enabled NetworkManager >/dev/null 2>&1 || \
  error "NetworkManager is not enabled"

# Disk usage
df -h / | awk 'NR==2 {print "Root usage:", $5}'

# Kernel
uname -r | awk '{print "Running kernel:", $0}'

echo
echo "Sanity check completed successfully."
