---
title: Backup & Restore a database
author: lamngockhuong
date: 2023-10-14 16:15:00 +0700
categories: [Database]
tags: [mysql, postgresql]
image:
  path: /posts/2023/10/sql.png
  width: 800
  height: 500
---

## MySQL

### Backup with mysqldump

👉 Backup the database from the local Docker container:

```bash
docker exec [mysql_container_id] sh -c 'exec mysqldump -u[user] -p[password] [database_name]' > backup-$(date +%y%m%d%H%M%S).sql

# example
# container name: 127c93385edc
# user: root, password: 123456, database name: db_test
docker exec 127c93385edc sh -c 'exec mysqldump -uroot -p123456 db_test' > /Users/lamngockhuong/develop/backup-$(date +%y%m%d%H%M%S).sql
```

👉 Backup the database from the remote MySQL datebase server:

```bash
docker exec [mysql_container_id] sh -c 'exec mysqldump -h[remote_host] --port=[port] -u[user] -p[password] [database_name]' > backup-$(date +%y%m%d%H%M%S).sql

# example
docker exec 127c93385edc sh -c 'exec mysqldump -h172.1.100.110 --port=3306 -uroot -p123456 db_test' > /Users/lamngockhuong/develop/backup-$(date +%y%m%d%H%M%S).sql
```

### Restore with mysql

👉 Restore the database to the local Docker container:

```bash
docker exec -i [mysql_container_id] sh -c 'exec mysql -u[user] -p[password] [database_name]' < [file_name].sql

# example
docker exec -i 127c93385edc sh -c 'exec mysql -uroot -p123456 db_test' < /Users/lamngockhuong/develop/db_backup.sql
```

👉 Restore the database to the remote MySQL database server:

```bash
docker exec -i [mysql_container_id] sh -c 'exec mysql -h[remote_host] --port=[port] -u[user] -p[password] [database_name]' < [file_name].sql

# example
docker exec -i 127c93385edc sh -c 'exec mysql -h172.1.100.110 --port=3306 -uroot -p123456 db_test' < /Users/lamngockhuong/develop/db_backup.sql
```

## PostgreSQL

### Backup with pg_dump

👉 Backup the database from the local Docker container:

```bash
docker exec -t --user [user] [postgresql_container_id] pg_dump -U [user] [database_name] > dump_$(date +%y%m%d%H%M%S).sql

# example
docker exec -t --user postgres 127c93385edc pg_dumpall -U postgres db_test > dump_$(date +%y%m%d%H%M%S).sql
```

### Restore with psql

👉 Restore the database to the local Docker container:

```bash
cat [file_name].sql | docker exec -i --user [user] 127c93385edc psql -U [user]

#example
cat dump.sql | docker exec -i --user postgres 127c93385edc psql -U postgres
```
