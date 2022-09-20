---
title: Deploy a Docker container with SSH access
author: lamngockhuong
date: 2022-09-20 18:20:00 +0700
categories: [Linux]
tags: [linux, docker, ubuntu, ssh]
---

## Prepare Dockerfile, image, container and IP address

1. Dockerfile

```sh
FROM ubuntu:22.10

RUN apt update && apt install -y openssh-server nano

RUN mkdir /var/run/sshd

# Aa@123456 is root password
RUN echo 'root:Aa@123456' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
```

2. Build the image and deploy the container

```console
docker build -t sshd_ubuntu .
docker run -d -P --name test_sshd sshd_ubuntu
```

3. Locate the IP address of the running container

$ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' test_sshd

// ex output: 172.17.0.2

## SSH into the running container (using password)

1. Tune SSH Daemon Configuration

```console
// docker exec -it <container_id> bash
docker exec -it test_sshd bash
nano /etc/ssh/sshd_config
```

- In that file (sshd_config), uncomment the line:

```shell
#PermitRootLogin yes
```

- That line should look like this:

```shell
PermitRootLogin yes
```

- Restart the SSH daemon:

```console
service ssh restart
docker restart test_sshd
```

2. SSH into the container

Using the root's password: Aa@123456

```console
// ssh root@IP
ssh root@172.17.0.2
```

## SSH into the running container (using SSH key)

- Create a RSA Key Pair

```console
ssh-keygen -t rsa
```

- Add id_rsa.pub to remote server (docker container)

```console
cat ~/.ssh/id_rsa.pub | ssh root@172.17.0.2 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
```

## References

- [How to deploy a Docker container with SSH access](https://www.techrepublic.com/article/deploy-docker-container-ssh-access/)
- [Fixing "System has not been booted with systemd as init system" Error](https://linuxhandbook.com/system-has-not-been-booted-with-systemd/)
- [How to add ssh keys to an ubuntu server](https://medium.com/@williamkwao/how-to-add-ssh-keys-to-an-ubuntu-server-6a3a5b1bee26)
