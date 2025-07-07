---
title: AWS CLI for EC2
description: Some AWS CLIs for EC2
author: lamngockhuong
date: 2022-09-30 12:00:00 +0700
categories: [Cloud & Hosting, AWS]
tags: [aws, ec2, cli, linux]
image:
  path: /posts/2023/10/aws.png
  width: 800
  height: 500
---

## Examples

### Example 1: List All instances from Default Region

```console
aws ec2 describe-instances
```

### Example 2: List All instances with query

- With all informations

```console
aws ec2 describe-instances \
--region "us-east-1" \
--query "Reservations[].Instances[]"
```

- With IAM, Security Group

```console
aws ec2 describe-instances \
--region "us-east-1" \
--query "Reservations[].Instances[].{InstanceId:InstanceId,Name:Tags[?Key=='Name']|[0].Value,InstanceType:InstanceType,PrivateIp:PrivateIpAddress,PublicIP:PublicIpAddress,SubnetId:SubnetId,VpcId:VpcId,Groups:join(',',NetworkInterfaces[].Groups[].GroupId),IamInstanceProfile:IamInstanceProfile.Arn}" \
--output table
```

### Example 3: Start, Stop instance

```console
aws ec2 stop-instances --instance-ids <instance id>
```

```console
aws ec2 stop-instances --instance-ids <instance id>
```

## References

- [AWS EC2 CLI](https://docs.aws.amazon.com/cli/latest/reference/ec2/index.html#cli-aws-ec2)
