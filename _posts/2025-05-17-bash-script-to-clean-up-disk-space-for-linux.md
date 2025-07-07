---
title: Bash script to clean up disk space for Linux
author: lamngockhuong
date: 2025-05-17 22:35:00 +0700
categories: [System & OS, Linux]
tags: [linux, unix, commands, ubuntu, debian, alpine, clean, disk]
image:
  path: /posts/2023/10/linux.png
  alt: "Linux disk cleanup script"
  width: 800
  height: 500
---

A handy interactive Bash script to inspect and optionally clean up disk space used by common development tools and system caches on Ubuntu (or any Linux system).

## What it does

* Scans common dev tool folders (e.g. `.npm`, `.yarn`, `.m2`, `.gradle`, `.nvm`, `snap`, etc.) and shows their sizes.
* Prompts for deletion of each folder individually.
* Reports disk usage of:

  * APT package cache
  * `journalctl` system logs
  * Docker system (images, volumes, containers)
* Prompts separately before cleaning:

  * APT cache (`sudo apt autoremove && apt clean`)
  * Systemd journal logs (`journalctl --vacuum-time=7d`)
  * Docker unused data (`docker system prune -a`)

## Features

* Simple interactive prompts for safe manual control
* Works well on local dev machines or CI runners with disk pressure
* Requires no dependencies besides standard Linux tools

## Usage

Download and run:

```bash
chmod +x check-disk-usage.sh
./check-disk-usage.sh
```

Or run directly from Gist in one line:

```bash
bash <(curl -L https://go.khuong.dev/check-disk-usage)
```

## References

* [lamngockhuong/check-disk-usage.sh](https://gist.github.com/lamngockhuong/7c5ba9565b660c723aa36b483a408443)
