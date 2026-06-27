# 5K Linux

**5K** is a minimal, Arch-based Linux distribution. It ships as a live ISO with a
**TUI installer** that sets up a **minimal KDE Plasma** desktop with the
**JetBrainsMono Nerd Font** enabled by default, plus a custom **fastfetch**
greeting.

This repository is an [archiso](https://wiki.archlinux.org/title/Archiso)
profile. Building it produces a bootable `5k-*.iso`.

## Features

- **TUI installer** (`5k-install`) built on `dialog` — disk selection,
  partitioning, user/root setup, locale/timezone/keymap, and bootloader install.
- **Minimal KDE Plasma** — `plasma-desktop` + SDDM + a small set of essentials
  (Konsole, Dolphin, Kate, network/audio applets) rather than the full
  `plasma`/`kde-applications` groups.
- **JetBrainsMono Nerd Font by default** — installed and wired up as the default
  monospace font via fontconfig, KDE `kdeglobals`, and a Konsole profile.
- **Custom 5K fastfetch** — custom ASCII logo and module layout, shown on login
  in both the live ISO and the installed system.
- **UEFI + BIOS** boot support (systemd-boot on the ISO; GRUB on the installed
  system).

## Repository layout

| Path | Purpose |
| --- | --- |
| `profiledef.sh` | archiso profile definition (ISO name, boot modes, permissions). |
| `packages.x86_64` | Packages included in the **live ISO**. |
| `pacman.conf` | pacman config used during the build. |
| `efiboot/`, `syslinux/` | Bootloader configuration for the ISO. |
| `airootfs/` | Files overlaid onto the live root filesystem. |
| `airootfs/usr/local/bin/5k-install` | The TUI installer. |
| `airootfs/usr/local/bin/5k-welcome` | Live-ISO welcome screen that launches the installer. |
| `airootfs/usr/share/5k/fastfetch.jsonc` | Custom fastfetch config. |
| `airootfs/usr/share/5k/logo.txt` | Custom 5K fastfetch logo. |
| `build.sh` | Build the ISO with `mkarchiso` (run on Arch, as root). |
| `build-docker.sh` | Build the ISO inside an Arch container (any host with Docker/Podman). |

## Building the ISO

### Option A — on Arch Linux

```bash
sudo pacman -S archiso
sudo ./build.sh
# ISO is written to ./out/
```

### Option B — anywhere with Docker or Podman

```bash
./build-docker.sh
# ISO is written to ./out/
```

> The container runs `--privileged` because `mkarchiso` needs loop devices.

## Trying the ISO

Boot `out/5k-*.iso` in a VM (QEMU/VirtualBox/VMware) or on real hardware:

```bash
# UEFI example with QEMU
qemu-system-x86_64 -enable-kvm -m 4096 \
  -bios /usr/share/edk2/x64/OVMF.4m.fd \
  -cdrom out/5k-*.iso
```

The live environment auto-logs in on tty1 and launches the welcome screen, which
offers to start `5k-install`.

## What the installer does

1. Detects UEFI vs BIOS.
2. Checks connectivity (offers `nmtui` if offline).
3. Lets you pick and **erase** a target disk, then partitions and formats it.
4. `pacstrap`s the base system + minimal KDE + JetBrainsMono Nerd Font + fastfetch.
5. Configures locale, timezone, keymap, hostname, root password, and a user
   (in the `wheel` sudo group).
6. Installs GRUB and enables **NetworkManager** and **SDDM**.
7. Deploys the 5K fastfetch config and the default font settings.

> **Warning:** the installer erases the selected disk. Use a VM or a spare
> machine for testing.
