# Step 08 — Final Verification and Benchmark

This step verifies that the system is clean, fast, and stable.

## Verify partition layout

lsblk -f

Only Linux partitions should remain.

## Verify EFI entries

efibootmgr

Only one Linux entry should exist.

## Measure boot time

systemd-analyze

Expected:
- Loader: under 3 seconds
- Kernel: under 3 seconds
- Userspace: under 10 seconds

## Final state

- No Windows remnants
- Single EFI boot entry
- Fast and predictable boot
- Stable Wi-Fi autoconnect

The system is now fully cleaned and optimized.
