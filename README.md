# wipe-windows-uefi-linux-cleanboot

This repository documents a **real-world, UEFI-based migration from Windows/Linux dual-boot to a Linux-only system**, with a focus on correctness, safety, and reproducibility.

It is not a beginner tutorial. The procedures assume familiarity with:
- UEFI firmware and EFI System Partitions (ESP)
- GPT partition tables
- systemd-based Linux distributions (Manjaro / Arch family)
- Command-line tooling

The goal is a **clean Linux-only boot**:
- No Windows partitions
- No orphan EFI entries
- No PXE/network boot delays
- Fast, deterministic startup

---

## Scope

This repository covers:

- Safely removing Windows from a UEFI dual-boot system
- Expanding Linux partitions to reclaim disk space
- Cleaning and validating EFI boot entries
- Debugging and optimizing slow boot times
- Identifying side effects caused by VPNs and network stack changes
- Final sanity checks to ensure system integrity

It explicitly avoids:
- Blind use of graphical partitioners
- Mixing MBR and GPT concepts
- Reinstalling the OS when not necessary

---

## Repository Structure

```
.
├── README.md
├── docs/
│   ├── 01-prechecks.md
│   ├── 02-wipe-windows.md
│   ├── 03-clean-efi.md
│   ├── 04-disable-unnecessary-services.md
│   ├── 04-linux-only-disk-layout.md
│   ├── 05-boot-time-debug.md
│   ├── 05-plymouth-and-boot-splash.md
│   ├── 06-plymouth-and-black-screen.md
│   ├── 06-wifi-autoconnect-fix.md
│   ├── 07-network-and-vpn-side-effects.md
│   ├── 07-remove-leftover-kernels.md
│   ├── 08-final-validation.md
│   └── 08-final-verification.md
├── scripts/
│   ├── boot-analyze.sh
│   ├── list-efi-entries.sh
│   └── sanity-check.sh
```

---

## Workflow Overview

The documentation is meant to be followed **in order**.

### 1. Prechecks
`docs/01-prechecks.md`

Confirm firmware mode, partition layout, and backup status before touching anything.

### 2. Remove Windows Partitions
`docs/02-wipe-windows.md`

Delete Windows NTFS and recovery partitions while preserving the Linux ESP and root filesystem.

### 3. Clean EFI Entries
`docs/03-clean-efi.md`

Remove stale Windows and PXE boot entries from NVRAM. Ensure Linux bootloader is the only default.

### 4. Validate Disk Layout
`docs/04-linux-only-disk-layout.md`

Confirm a single ESP and a single Linux root partition occupying the disk.

### 5. Boot Time Analysis
`docs/05-boot-time-debug.md`

Use systemd tooling to identify slow firmware, loader, kernel, or userspace stages.

### 6. Boot Splash and Black Screen Fixes
`docs/05-plymouth-and-boot-splash.md`  
`docs/06-plymouth-and-black-screen.md`

Remove unnecessary Plymouth waits and fix long black screens before graphical login.

### 7. Network and VPN Side Effects
`docs/06-wifi-autoconnect-fix.md`  
`docs/07-network-and-vpn-side-effects.md`

Handle NetworkManager autoconnect issues and excessive TUN interfaces created by VPN software.

### 8. Final Validation
`docs/08-final-validation.md`  
`docs/08-final-verification.md`

Confirm boot speed, EFI state, filesystem integrity, and active services.

---

## Scripts

The `scripts/` directory contains **read-only diagnostic tools**.

### boot-analyze.sh
Runs systemd boot analysis and highlights bottlenecks.

```bash
./scripts/boot-analyze.sh
```

### list-efi-entries.sh
Lists EFI boot entries and mounted ESPs.

```bash
sudo ./scripts/list-efi-entries.sh
```

### sanity-check.sh
Performs final consistency checks. Exits with non-zero status on error.

```bash
sudo ./scripts/sanity-check.sh
```

---

## Supported Systems

- UEFI firmware only
- GPT partitioned disks
- systemd-based Linux distributions

Tested primarily on:
- Manjaro Linux (GNOME)
- Arch Linux (conceptually equivalent)

---

## Disclaimer

This repository reflects a **real system migration**.  
Commands that modify partitions or EFI variables are inherently destructive.

Always verify:
- Backups
- Disk identifiers
- Partition numbers

before executing any write operation.

---

## License

MIT