---
title: Useful Linux and Unix commands
author: lamngockhuong
date: 2022-04-21 10:25:00 +0700
categories: [Linux]
tags: [linux, unix, commands, ubuntu, debian, alpine]
---
## Debian/Ubuntu Useful Commands

### Check OS version
```console
cat /etc/os-release
```

### Search text from terminal
```console
grep -rnwi '/path/file.js' -e 'keyword_not_case_sensitive'
```

### Show some logs, contents from line X to Y
```
X=1  
Y=5
sed -n -e "$X,$Y p" -e "$Y q" file_name.txt
```

### Kill a process on a specific port
```console
sudo kill -9 30 // Kill process ID = 30
sudo kill -9 $(sudo lsof -t -i:8080) // Find process on port 8080 and kill it
```
## Alpine Useful Commands
Updating...

## References
