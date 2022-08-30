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
### Uninstall the AWS CLI
1. Locate the symlink and install paths.
Use the `which` command to find the symlink.
```console
which aws
/usr/local/bin/aws
```
Use `ls` command to find the directory that the symlink points to.
```console
ls -l /usr/local/bin/aws
lrwxrwxrwx 1 ec2-user ec2-user 49 Oct 22 09:49 /usr/local/bin/aws -> /usr/local/aws-cli/v2/current/bin/aws
```
2. Delete the two symlinks
```console
sudo rm /usr/local/bin/aws
sudo rm /usr/local/bin/aws_completer
```
3. Delete the install directory.
```console
sudo rm -rf /usr/local/aws-cli
```
4. (Optional) Remove the shared AWS SDK and AWS CLI settings information in the .aws folder.
```console
sudo rm -rf ~/.aws/
```

## References
+ [AWS Installing docs](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
+ [AWS Uninstalling docs](https://docs.aws.amazon.com/cli/latest/userguide/uninstall.html)
