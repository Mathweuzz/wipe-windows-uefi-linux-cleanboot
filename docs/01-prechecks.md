# 01 — Pre-checks Before Wiping Windows (UEFI Systems)

This document describes **mandatory verification steps** before removing Windows
and performing a clean UEFI Linux-only installation.

Skipping any step in this section may result in:

* Unbootable systems
* Broken EFI entries
* Data loss
* Firmware fallback to PXE / network boot
* Extremely slow boot times

---

## 1. Confirm Boot Mode (UEFI only)

Legacy/CSM installations are **not supported**.

Command:

```
ls /sys/firmware/efi
```

Expected result:

* Directory exists → system is booted in **UEFI mode**
* If it does not exist → STOP immediately

---

## 2. Identify Disk Layout

List all disks and partitions:

```
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
```

You must clearly identify:

* Main system disk (usually `nvme0n1` or `sda`)
* EFI System Partition (ESP), typically:

  * FAT32
  * ~100–500 MB
  * Mounted at `/boot/efi`

Example layout:

```
nvme0n1
├─nvme0n1p4  vfat   /boot/efi
└─nvme0n1p5  ext4   /
```

---

## 3. Confirm Root Filesystem

Commands:

```
findmnt /
df -h /
```

Verify that:

* Root (`/`) is mounted from the expected partition
* No Windows partitions are mounted

---

## 4. Dump Existing EFI Boot Entries (CRITICAL)

Before touching EFI, **always back up the current state**.

Command:

```
sudo efibootmgr -v
```

Save the output:

```
sudo efibootmgr -v > ~/efibootmgr-before.txt
```

This file allows recovery if firmware entries are accidentally removed.

---

## 5. Backup EFI Partition (MANDATORY)

Check where EFI is mounted:

```
mount | grep efi
```

Create a full backup:

```
sudo mkdir -p ~/efi-backup
sudo cp -r /boot/efi/* ~/efi-backup/
```

Optional (recommended): compress the backup

```
tar -czvf ~/efi-backup.tar.gz ~/efi-backup
```

---

## 6. Verify Existing EFI Loaders

List EFI directories:

```
ls /boot/efi/EFI
```

You may see directories such as:

* `Microsoft`
* `ubuntu`
* `Manjaro`

Presence does **not** mean they are active. Handling happens in later steps.

---

## 7. Confirm Secure Boot State

Command:

```
mokutil --sb-state
```

Document whether Secure Boot is:

* Disabled (recommended)
* Enabled (must be handled explicitly later)

---

## 8. Kernel and Initramfs Sanity Check

Commands:

```
uname -r
ls /boot
```

Ensure:

* At least one working kernel is installed
* Matching initramfs images exist

---

## 9. Network and VPN Safety Check

Ensure no VPN tunnels are active before disk operations.

Command:

```
ip a | grep tun
```

If any `tunX` interfaces exist, disconnect VPN software first.

---

## 10. Final Pre-check Checklist

Confirm all items below before proceeding:

* [ ] System booted in UEFI mode
* [ ] Correct disk identified
* [ ] EFI partition backed up
* [ ] EFI boot entries exported
* [ ] Secure Boot state known
* [ ] VPN disconnected

Only after **all checks pass**, proceed to the next document.

➡ Next: `docs/02-wipe-windows.md`
