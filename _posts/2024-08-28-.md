---
title: The useful commands for PostgreSQL
author: lamngockhuong
date: 2024-08-28 09:45:00 +0700
categories: [Database, PostgreSQL]
tags: [postgresql, psql]
image:
  path: /posts/2024/08/postgresql.png
  width: 800
  height: 500
---

## Common

### Connect to the database from the command line

```bash
psql -h 127.1.2.3 -U postgres_user database_name
```

## Database

### Create a new database

```sql
# Create a new database with the custom lc_collate, lc_ctype
CREATE DATABASE "database_name" ENCODING 'UTF8' LC_COLLATE = 'ja_JP.UTF-8' LC_CTYPE = 'ja_JP.UTF-8' TEMPLATE template0;
```

### Rename the database

```sql
ALTER DATABASE database_name RENAME TO database_name_new;
```

### Drop the database

```sql
DROP DATABASE database_name;
```

## User & Role

### Retrieves information about all users

```sql
SElECT * from pg_catalog.pg_user;
```

### Get the database's encoding and owner information.

```sql
select d.datname as "Name", d.datcollate as "Collate", d.datctype as "CType", pg_catalog.pg_get_userbyid(d.datdba) as "Owner" from pg_catalog.pg_database d;
```

### Modify the database owner

```sql
ALTER DATABASE database_name OWNER TO cloudsqlsuperuser;
```

### Retrieve and summarize the table privileges granted to users

```sql
SELECT grantee AS user, CONCAT(table_schema, '.', table_name) AS table, 
    CASE 
        WHEN COUNT(privilege_type) = 7 THEN 'ALL'
        ELSE ARRAY_TO_STRING(ARRAY_AGG(privilege_type), ', ')
    END AS grants
FROM information_schema.role_table_grants
GROUP BY table_name, table_schema, grantee;
```

### Grant specific privileges to a user

```sql
GRANT SELECT, USAGE ON SEQUENCE public.migrations_id_seq TO postgres_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres_user;
```

## Backup & restore

Refer to: [Backup & Restore a database](/posts/backup-and-restore-a-database)