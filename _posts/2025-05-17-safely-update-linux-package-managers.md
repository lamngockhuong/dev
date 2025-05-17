---
title: Safely Update Linux Package Managers
author: lamngockhuong
date: 2025-05-17 22:15:00 +0700
categories: [Linux]
tags: [linux, unix, commands, ubuntu, debian, alpine, update]
image:
  path: /posts/2023/10/linux.png
  width: 800
  height: 500
---

A portable Bash script to update all major package managers on any Linux distribution while ensuring safety. It avoids disruptive upgrades by using commands like `apt upgrade` instead of `dist-upgrade`, performs post-update cleanup for certain package managers (e.g., APT, Homebrew, and DNF), and only updates package managers detected on the system to prevent unnecessary operations. It supports APT, DNF, YUM, Pacman, Zypper, APK, Emerge, Nix, Snap, Flatpak, and Homebrew.

## Features

- ✅ **Cross-distro support**: Works with Debian, Ubuntu, Fedora, RHEL, CentOS, Arch, Manjaro, openSUSE, Alpine, Gentoo, and NixOS.
- 📦 **Supports 11 package managers**: `apt`, `dnf`, `yum`, `pacman`, `zypper`, `apk`, `emerge`, `nix-env`, `snap`, `flatpak`, and `brew`.
- 🔍 **Auto-detection**: Automatically detects your Linux distribution and available package managers.
- 🧹 **Cleanup included**: Performs post-update cleanup for APT, Homebrew, and DNF.
- 🔒 **Safe operations**: Uses `apt upgrade` instead of `dist-upgrade` to avoid disruptive upgrades.
- ⚙️ **Modular & extensible**: Easy to add more logic for distro-specific updates.

## Usage

Download [the script update-everything.sh here](https://gist.github.com/lamngockhuong/d6b4b036265a6c1a8daa9ff57d0e28ba) and run:

```bash
chmod +x update-everything.sh
./update-everything.sh
```

Or run directly from Gist in one line:

```bash
bash <(curl -L https://go.khuong.dev/update-everything-script)
```

> **Note**: Most package managers (APT, DNF, Snap, etc.) require `sudo` access. Ensure you trust the script and its source before granting elevated privileges to avoid potential security risks.

## References

- [lamngockhuong/update-everything.sh](https://gist.github.com/lamngockhuong/d6b4b036265a6c1a8daa9ff57d0e28ba)
