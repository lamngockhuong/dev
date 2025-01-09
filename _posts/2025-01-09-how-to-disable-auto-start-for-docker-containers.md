---
title: How to Disable Auto-Start for Docker Containers
author: lamngockhuong
date: 2025-01-09 11:00 +0700
categories: [Docker]
tags: [docker]
image:
  path: /posts/2023/10/docker.png
  width: 800
  height: 500
---

Docker containers are an essential part of modern development workflows, but sometimes, an automatically starting container can cause unnecessary overhead when you boot your machine. If you want to stop a Docker container from starting automatically, follow these simple steps:

## 1. Check Running Containers
First, list all containers to identify the one you want to modify:
```bash
docker ps -a
```

## 2. Inspect the Restart Policy
Check the current restart policy for your container:
```bash
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>
```

## 3. Update the Restart Policy
Disable auto-start by updating the restart policy to `no`:
```bash
docker update --restart=no <container_name_or_id>
```

## 4. Confirm Changes
Verify the updated restart policy:
```bash
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>
```

## 5. Reboot and Test
Restart your computer and confirm that the container no longer starts automatically:
```bash
docker ps
```

## Re-Enabling Auto-Start (Optional)
If you ever need the container to auto-start again, you can use:
```bash
docker update --restart=always <container_name_or_id>
```

With these steps, you have full control over which containers start automatically on your machine. Happy coding! ⚡️
