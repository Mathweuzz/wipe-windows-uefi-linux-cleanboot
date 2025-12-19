# Step 05 — Plymouth and Boot Splash Cleanup

Plymouth is often responsible for long black screens during boot.

## Remove Plymouth entirely (recommended)

sudo pacman -Rns plymouth

## Clean GRUB configuration

Edit GRUB defaults:

sudo nano /etc/default/grub

Ensure these lines:

GRUB_TIMEOUT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3"

Update GRUB:

sudo update-grub

## Result

Boot will proceed directly from firmware to kernel,
without unnecessary splash delays.
