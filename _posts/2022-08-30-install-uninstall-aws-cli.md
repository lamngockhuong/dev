---
title: Installing, uninstalling or updating the latest version of the AWS CLI
author: lamngockhuong
date: 2022-08-30 17:45:00 +0700
categories: [AWS]
tags: [aws, ubuntu, aws-cli]
---
## Linux
### Install or update the AWS CLI
***Linux x86 (64-bit):**
```console
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
***Linux ARM**
```console
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

## References
+ [AWS docs](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
