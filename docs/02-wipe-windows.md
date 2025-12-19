# Step 02 — Removing Windows from a UEFI/GPT System

This document describes the correct and safe procedure to remove a Windows installation from a system that uses UEFI firmware and a GPT partition table, while preserving a working Linux installation.

The goal of this step is **only** to remove Windows-related partitions and prepare the disk for later reallocation. Bootloader cleanup, filesystem expansion, and performance tuning are intentionally handled in later steps.

---

## Preconditions

Before proceeding, ensure that:

- The system boots correctly into Linux
- You have a verified backup of important data
- You understand which disk contains the operating system (e.g. `/dev/nvme0n1`)

---

## Inspecting the current disk layout

Always start by inspecting the disk and partition layout.

```bash
lsblk -f
sudo parted /dev/nvme0n1 print
```

You should identify:

- The Linux root partition (usually `ext4` or `btrfs`)
- The EFI System Partition (ESP), typically `FAT32` and around 100–500 MB
- Windows-related partitions (NTFS, recovery, diagnostic)

Do **not** delete anything until this layout is clearly understood.

---

## Identifying Windows partitions

Common Windows partitions include:

- Large `ntfs` partitions (Windows system and data)
- Small recovery or diagnostic partitions (often 500–1000 MB)
- OEM-specific partitions

Linux partitions (root, home) and the active EFI System Partition must be preserved.

---

## Removing Windows partitions

Enter `parted` for controlled removal:

```bash
sudo parted /dev/nvme0n1
```

Inside `parted`, remove **only** Windows-related partitions:

```bash
rm <partition_number>
```

Repeat for each Windows partition.

After removal, print the layout again:

```bash
print
```

At this stage, the disk will contain unallocated space where Windows previously resided.

---

## Important considerations

### EFI System Partition (ESP)

On many dual-boot systems, Linux and Windows share the same EFI partition.  
Do **not** delete the EFI partition unless you are absolutely certain Linux is not using it.

The ESP should only be removed if:

- A new EFI partition already exists
- Linux boot files are confirmed to be present on the new ESP

If unsure, leave the ESP untouched.

---

## Common mistakes during Windows removal on UEFI systems

The following mistakes frequently lead to unbootable systems or corrupted layouts:

- Deleting the active EFI System Partition without confirming Linux boot dependencies
- Performing partition operations without inspecting the current disk layout
- Applying legacy MBR assumptions to a GPT-based UEFI system
- Resizing filesystems before resizing their partitions
- Reinstalling the bootloader before the disk layout is finalized

Avoiding these mistakes is critical for a clean and recoverable system state.

---

## Expected result

After completing this step:

- All Windows partitions are removed
- The disk contains unallocated space
- Linux continues to boot normally
- No filesystem resizing has been performed yet

The system is now ready for EFI cleanup and filesystem expansion, which are handled in subsequent steps.

---

## Next step

Proceed to **Step 03 — EFI cleanup and firmware entries**.