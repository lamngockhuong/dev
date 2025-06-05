---
title: Run the SQL commands on Windows PowerShell
description: How to run the SQL commands on Windows PowerShell
author: lamngockhuong
date: 2024-04-10 18:30:00 +0700
categories: [PowerShell]
tags: [windows, sql, powershell]
image:
  path: /posts/2024/04/powershell.jpg
  width: 800
  height: 500
---

```shell
$SqlPath = "$([System.IO.Path]::GetFullPath("$($MyInvocation.MyCommand.Path)\.."))\sql"

$DBHost = "localhost"
$DBPort = "5432"
$DBName = "myapp"
$DBUser = "postgres"
$DBPassword = "postgres"

$Env:PGPASSWORD = $DBPassword

# Check Database name exist
$PsqlCommand = "psql -U $DBUser -h $DBHost -p $DBPort -d postgres -c 'SELECT datname FROM pg_catalog.pg_database WHERE datname = ''$DBName'';'"
$Result = Invoke-Expression -Command $PsqlCommand

if ($Result -match $DBName) {
    Write-Host "Database $DBName exists!"
    Exit 1
}

# Run SQL command from the sql file
$PsqlCommand = "psql -U $DBUser -h $DBHost -p $DBPort -d postgres -f $SqlPath/query.sql"
Invoke-Expression $PsqlCommand
```
