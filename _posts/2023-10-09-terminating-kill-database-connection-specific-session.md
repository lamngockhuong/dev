---
title: Terminating (kill) database connection, specific session
author: lamngockhuong
date: 2023-10-09 18:40:00 +0700
categories: [Database]
tags: [mysql, postgres]
image:
  path: /posts/2023/10/sql.png
  width: 800
  height: 500
---

## PostgreSQL

### Find session ID (pid)

```sql
SELECT *
FROM pg_stat_activity
WHERE datname = 'dbname' # postgres database
AND usename = 'apiuser'  # postgres username
```
### Kill session

- `pg_cancel_backend(pid)`: Terminate a query but keep the connection alive
- `pg_terminate_backend(pid)`: Terminate a query and kill the connection

**Kill session by pid:**

```sql
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE pid = '123456';
```

**Kill all sessions except `pg_backend_pid`** (our own PID)
```sql
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE pid <> pg_backend_pid()
AND datname = 'dbname' # postgres database
AND usename = 'apiuser'  # postgres username
```

## MySQL

```sql
SHOW FULL PROCESSLIST;

KILL 123456;
```

**Some helpful commands:**

```sql
SELECT concat('KILL ',id,';') FROM information_schema.processlist WHERE user = 'root';

SELECT concat('KILL ',id,';') FROM information_schema.processlist WHERE user = 'root' INTO outfile '/tmp/out.txt';
```

## References

- [Terminate (kill) specific session in PostgreSQL database](https://dataedo.com/kb/query/postgresql/kill-session)
- [How to terminate PostgreSQL database connections](https://www.cybertec-postgresql.com/en/terminating-database-connections-in-postgresql/)
