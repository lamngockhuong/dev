---
title: Register Scheduled Task on Windows Task Scheduler
author: lamngockhuong
date: 2024-04-09 17:15:00 +0700
categories: [PowerShell]
tags: [windows, powershell, scheduled]
image:
  path: /posts/2024/04/powershell.jpg
  width: 800
  height: 500
---
## Register Scheduled Task

```shell
$ScriptPath = "$([System.IO.Path]::GetFullPath("$($MyInvocation.MyCommand.Path)\.."))\script"
$TaskName = "CleanData"
$TaskFolder = "\MyApp"

$Trigger = New-ScheduledTaskTrigger -Daily -At 3pm
$Action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-WindowStyle Hidden -File $ScriptPath\database\clean_data.ps1"
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings (New-ScheduledTaskSettingsSet)
Register-ScheduledTask -TaskName $TaskName -InputObject $Task -TaskPath $TaskFolder -User $(whoami) -Force
```

## Unregister Scheduled Task

```shell
$TaskName = "CleanData"
$TaskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $TaskName }

if ($TaskExists) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Host "Scheduled Task $TaskName is removed successfully"
} else {
    Write-Host "Scheduled Task $TaskName is not exist"
}
```
