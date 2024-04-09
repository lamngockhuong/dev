---
title: The helpful PowerShell Functions and Commands
author: lamngockhuong
date: 2024-04-09 17:00:00 +0700
categories: [PowerShell]
tags: [windows, powershell]
image:
  path: /posts/2024/04/powershell.jpg
  width: 800
  height: 500
---
## 1. Check Status and Stop the Service

```shell
function Stop-Service {
    Param (
        [ValidateSet("TCP", "UDP")] $Method,
        $Port
    )

    $Process = Get-Process -Method $Method -Port $Port

    if ($Process) {
        Stop-Process -Id $Process.OwningProcess -Force
        Write-Host "Process with PID $($Process.OwningProcess) has been terminated."
    } else {
        Write-Host -f Red "Process is not found on port $Port."
    }
}

function Show-Status {
    Param (
        [ValidateSet("TCP", "UDP")] $Method,
        $Port
    )

    $Process = Get-Process -Method $Method -Port $Port

    if ($Process) {
        Write-Host -f Green "Has a process with PID $($Process.OwningProcess) on port $Port."
    } else {
        Write-Host -f Red "No process found on port $Port."
    }
}

function Get-Process {
    Param (
        [ValidateSet("TCP", "UDP")] $Method,
        $Port
    )

    if ($Method -eq "TCP") {
        return Test-TCP-Status $Port
    } elseif ($Method -eq "UDP") {
        return Test-UDP-Status $Port
    }
}

function Test-TCP-Status {
    Param ($Port)
    return Get-NetTCPConnection -State Listen | Where-Object { $_.LocalPort -eq $Port } | Select-Object -First 1
}

function Test-UDP-Status {
    Param ($Port)
    return Get-NetUDPEndpoint | Where-Object { $_.LocalPort -eq $Port } | Select-Object -First 1
}
```

How to use:

```shell
function test {
    $Process = Get-Process -Method TCP -Port 5050
    if ($Process) {
        Write-Host -f Green "Process with PID $($Process.OwningProcess) is running."
        Stop-Service -Method TCP -Port 5050
        Exit
    }
}

test
```

## 2. Waiting for the service to run

```shell
function Wait-For-Starting {
    Param (
        [ValidateSet("TCP", "UDP")] $Method,
        $Port
    )
    $i = 0
    if ($Method -eq "TCP") {
        while (-not (Test-TCP-Status $Port)) {
            $RunningText = "Starting" + ("." * ($i % 3))
            Write-Progress -Activity $RunningText -Status "Take ${i}s"
            Start-Sleep -Milliseconds 1000

            $i++

            if($i-eq "15") { # timeout after 15s
                Write-Host -f Red "Process can not run on port $Port."
                Exit
            }
        }
    } elseif ($Method -eq "UDP") {
        while (-not (Test-UDP-Status $Port)) {
            $RunningText = "Starting" + ("." * ($i % 3))
            Write-Progress -Activity $RunningText -Status "Take ${i}s"
            Start-Sleep -Milliseconds 1000

            $i++

            if($i-eq "15") { # timeout after 15s
                Write-Host -f Red "Process can not run on port $Port."
                Exit
            }
        }
    }
}
```

How to use:

```shell
Wait-For-Starting -Method TCP -Port 5050
```

***Note:** Refer to Test-TCP-Status and Test-UDP-Status Function from [#1](#1-check-status-and-stop-the-service)
