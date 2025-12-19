#!/usr/bin/env bash
set -euo pipefail

if [[ ! -d /sys/firmware/efi ]]; then
  echo "ERROR: System not booted in UEFI mode."
  exit 1
fi

echo "UEFI detected."
echo

echo "== EFI Boot Entries =="
efibootmgr -v
echo

echo "== Disk ESPs detected =="
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS | grep -i vfat
