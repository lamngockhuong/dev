---
title: Create new Linux User
author: lamngockhuong
date: 2023-10-14 14:30:00 +0700
categories: [Linux]
tags: [linux, ubuntu]
---

## Create new User

```bash
sudo adduser nguyen.van.a
```

## Add SSH key

```bash
sudo mkdir /home/nguyen.van.a/.ssh/
sudo chmod 0700 /home/nguyen.van.a/.ssh/
sudo -- sh -c "echo 'ssh-ed25519 AAAAC3NzaC1lZDi1NTE5AAAAILaLvLmaW9qIbUVo1aDHWZE9JehbNfIdTVif2aFGF0E0 me@ngockhuong' > /home/nguyen.van.a/.ssh/authorized_keys"
sudo chown -R nguyen.van.a:nguyen.van.a /home/nguyen.van.a/.ssh/
```

## Add User to Sudoers & Sudo Group

```bash
sudo usermod -aG sudo nguyen.van.a
groups nguyen.van.a
su - nguyen.van.a
```
