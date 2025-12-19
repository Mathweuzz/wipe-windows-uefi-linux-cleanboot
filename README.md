# Wipe Windows from UEFI and Fix Linux Boot Performance

This repository documents a **real-world migration** from a dual-boot
Windows + Linux system to a **Linux-only UEFI setup**, including:

- Complete Windows removal
- EFI cleanup (no ghost boot entries)
- Disk space recovery
- Boot performance diagnosis and optimization
- Fixing black screen delays during boot
- Handling corporate VPN side effects (Forcepoint case)

This is **not a generic tutorial**.
Every command here was executed on a real machine and validated.

---

## System Context

- UEFI firmware
- NVMe storage
- Linux (Manjaro GNOME)
- Corporate VPN previously installed (Forcepoint)
- Windows fully removed

---

## What This Repo Is *Not*

- Not distro-specific marketing
- Not beginner Linux content
- Not “click next” instructions

This repo assumes:
- You understand what UEFI is
- You are comfortable with the terminal
- You want full control over your system

---

## Contents

1. Pre-checks before removing Windows
2. Safely wiping Windows partitions
3. Cleaning EFI boot entries
4. Rebuilding a Linux-only disk layout
5. Diagnosing slow boot (`systemd-analyze`)
6. Fixing Plymouth and black screen delays
7. Network and VPN side effects
8. Final validation checklist

---

## Disclaimer

You are responsible for your data.
Read everything before running any command.
