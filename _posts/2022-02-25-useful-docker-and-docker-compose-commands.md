---
title: Useful Docker & docker-compose commands
author:
  name: Lam Ngoc Khuong
  link: https://github.com/lamngockhuong
date: 2022-02-25 15:00 +0700
categories: [Docker]
tags: [docker]
---

## Docker
### Commonly used Docker commands

| Command                      | Description |
|:-----------------------------|:--------|
| `docker version` | Show the docker version |
| `docker image ls` or `docker images` | List the docker images on the system. |
| `docker rmi <image_name>:<tag_version>` or `docker rmi <image_id>` | Remove the ocker image |
| `docker commit <container> <image_name>:<image_tag>` | Create a new docker image from a container is running. Example:<br> `docker commit c3f275de7e0a  khuongdev/testimage:version3`|
| `docker ps` | Show the health status of a container. |
| `docker ps -a` | Show all containers |
| `docker ps -a --format "{{"{{" }}.CreatedAt}}"` | Show container start time |
| `docker create -it [--name  <container name>] <image_name:tag or image_id>` | Create new container and run it. Use `-d` flag for daemon mode |
| `docker rename old_name new_name` | Rename a container |
| `docker logs <container>` | Show the container logs. For examples:<br>1. `docker logs --since 2022-10-19T12:00 devcontainer`<br>2. `docker logs --since 2022-03-13T10:00 --tail 10 devcontainer`<br>3. `docker logs --since 2019-03-13T10:00 --tail 10 --timestamps devcontainer`<br>4. `docker logs devcontainer -t 2>&1 \| grep "Caused by: org.springframework.web.client.ResourceAccessException: I/O error on POST request for "`<br>5. `docker logs --tail=10 -f <container_id or container_name>` |
| `docker rm <container>` | Remove a container |
| `docker rm $(docker ps -a -f status=exited -q)` | Remove all exited containers |
| `docker rm $(docker ps -a -q)` | Remove all containers |
| `docker cp <container>:<full path to container file> <destination directory on host>` | Copy files from a container to the host system. For example:<br>`docker cp khuongdev:/local/data/file.tmp /tmp/file.tmp` |
| `docker cp <full path to host file> <container>:<destination directory in container>` | Copies files from the host system to a container. For example:<br>`docker cp /tmp/file.tmp khuongdev:/local/data`|
| `docker exec -u <user name> -it <container name> <command line>` | Executes a command in a container while the container is running. Examples:<br> `docker exec -u khuong -it devcontainer /bin/bash`|
| `docker start <container>` | Start a stopped container. |
| `docker stop <container>` | Stop a running container. |
| `docker volume ls` | List the volume on the system. |
| `docker volume prune` | Remove all unused volumes. |
| `docker volume rm <one or more volume names>` | Remove the volume |
| `docker volume inspect <one or more volume names>` | Show the volume informations|
| `docker inspect <image id or name>` | Show the docker image information. |
| `docker inspect <container id or name>` | Show the docker container information. |
| `docker inspect -f '{{"{{" }}.Name}} {{"{{" }}range .NetworkSettings.Networks}}{{"{{" }}.IPAddress}}{{"{{" }}end}}' $(docker ps -a -q)` | Check the name and IP Address of the container is running |
| `docker inspect --format='{{"{{" }}.State.FinishedAt}}' <container_id or container_name> ` | Show container finish time |
| `docker inspect --format='{{"{{" }}.LogPath}}' <container_id hoặc container_name>` | Show the container log path |

## Docker Compose
