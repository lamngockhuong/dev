---
title: The useful commands for Redis
author: lamngockhuong
date: 2024-09-07 13:15:00 +0700
categories: [Database, Redis]
tags: [redis]
image:
  path: /posts/2024/09/redis.png
  width: 800
  height: 500
---

### [Monitor](https://redis.io/docs/latest/commands/monitor/)

MONITOR is a debugging command that streams back every command processed by the Redis server. It can help in understanding what is happening to the database.

```bash
redis-cli monitor
```
