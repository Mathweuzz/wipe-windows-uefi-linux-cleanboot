# Step 03 — EFI cleanup and boot order stabilization

This step documents how to clean leftover UEFI entries after removing Windows
and ensure a single, stable boot path for Linux systems.

## 1. Verify current boot entries

Check what the firmware currently knows:

    efibootmgr -v

Identify entries related to:
- Windows Boot Manager
- Old Linux installs
- PXE / Network boot
- Old USB devices

Only the active Linux entry should remain enabled.

## 2. Inspect the EFI System Partition (ESP)

Mount the ESP if not already mounted:

    mount | grep efi

If not mounted:

    sudo mount /dev/<ESP_PARTITION> /boot/efi

List EFI directories:

    ls /boot/efi/EFI

Typical valid directories:
- Manjaro
- BOOT

Directories that can usually be removed after Windows wipe:
- Microsoft
- ubuntu (if not used)

## 3. Remove unused EFI directories

Example:

    sudo rm -rf /boot/efi/EFI/Microsoft
    sudo rm -rf /boot/efi/EFI/ubuntu

Never remove the directory used by the active boot entry.

## 4. Remove unused UEFI boot entries

Delete entries by boot number:

    sudo efibootmgr -b <BOOTNUM> -B

Repeat for all unused entries.

## 5. Set a clean boot order

Set Manjaro as the only boot target:

    sudo efibootmgr -o <MANJARO_BOOTNUM>

Verify:

    efibootmgr

## 6. Validate boot loader timing

After cleanup, firmware loader time should be minimal.
Check after reboot:

    systemd-analyze

The "loader" phase should now be under a few seconds.

## Result

At this point:
- EFI contains only active boot files
- Firmware scans only one boot entry
- Boot delay caused by UEFI probing is eliminated