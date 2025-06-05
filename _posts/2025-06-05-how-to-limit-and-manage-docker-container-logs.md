---
title: How to Limit and Manage Docker Container Logs
author: lamngockhuong
date: 2025-06-05 11:15:00 +0700
categories: [Linux]
tags: [linux, docker, ubuntu]
image:
  path: /posts/2023/10/docker.png
  width: 800
  height: 500
---

If you're using Docker in production or development, container logs can silently consume a significant amount of disk space over time. By default, Docker uses the `json-file` log driver, which stores logs in large, ever-growing files unless configured otherwise.

Here’s a simple guide to **limit Docker logs and prevent disk space exhaustion**.

## Step 1: Configure Log Rotation Globally

Edit or create the Docker daemon configuration file:

```bash
sudo nano /etc/docker/daemon.json
```

Add the following content:

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```

This sets a 10MB max size per log file and keeps only 3 rotated files per container (i.e., \~30MB max per container).

Then, restart Docker:

```bash
sudo systemctl restart docker
```

## Step 2: Apply Log Limits to Specific Containers (Optional)

When running containers manually, you can override log settings:

```bash
docker run \
  --log-driver=json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  your-image
```

## Step 3: Locate and Clear Container Logs (if needed)

To find a container’s log file:

```bash
docker inspect <container-id> --format='{{.LogPath}}'
```

Clear it manually if it gets too large:

```bash
sudo truncate -s 0 /path/to/container-id-json.log
```

To truncate **all** container logs:

```bash
sudo find /var/lib/docker/containers/ -name "*-json.log" -exec truncate -s 0 {} \;
```

## Bonus: List All Large Log Files

```bash
sudo find /var/lib/docker/containers/ -name "*.log" -exec du -h {} + | sort -hr | head -20
```

**That's it!**
Now your Docker containers will no longer silently consume your disk space. Log management is crucial for performance, monitoring, and maintenance — and it only takes a few minutes to set up properly.

## References

- [Configure logging drivers](https://docs.docker.com/engine/logging/configure/)
