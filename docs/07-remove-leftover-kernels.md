# Step 07 — Remove Unused Kernels

Keeping multiple kernels increases initramfs and boot time.

## List installed kernels

mhwd-kernel -li

## Keep only one stable kernel

Example (remove older kernel):

sudo mhwd-kernel -r linux66

## Regenerate initramfs

sudo mkinitcpio -P

## Update GRUB

sudo update-grub
