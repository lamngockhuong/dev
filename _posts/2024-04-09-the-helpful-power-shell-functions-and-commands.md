---
title: The helpful PowerShell Functions and Commands
author: lamngockhuong
date: 2024-04-09 17:00:00 +0700
categories: [Programming Languages, PowerShell]
tags: [windows, powershell, java]
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

## 3. Check if the command exists

```shell
function Test-Command {
    Param ($Command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {
        if (Get-Command $Command) {
            return $True
        }
    }
    catch {
        return $False
    }
    finally {
        $ErrorActionPreference = $oldPreference
    }
}

# how to use
Write-Host (Test-Command java)
```

## 4. Get/set ENV

```shell
# Get the current value of the PATH variable
$CurrentPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
$NewPath = $CurrentPath + ";" + $Path

# Set the New Path to User ENV
[System.Environment]::SetEnvironmentVariable("PATH", $NewPath, [System.EnvironmentVariableTarget]::User)

# Set Path in the current session
$Env:PATH = "$dir\bin;$Env:PATH"
```

How to check if the path exists:

```shell
$Path = "C:\Program Files\Java\jdk-17.0.10\bin"
$PersistedPaths = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::User) -split ';'
if ($PersistedPaths -contains $Path) {
    Write-Host "Exist!"
}
```

How to set env variable in the current session:

```shell
[System.Environment]::SetEnvironmentVariable('host', "127.0.0.1")
```

## 4. Download File

```shell
$Url = "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%2B7/OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.msi"
$OutFile = "C:\Users\Admin\Documents\OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.msi"
Invoke-WebRequest -Uri $Url -OutFile $OutFile
```

## 5. Get the current path of the running script

```shell
$ScriptPath = $($MyInvocation.MyCommand.Path)
Write-Host $ScriptPath

# Get the parent path of that script
$ParentPath = $([System.IO.Path]::GetFullPath("$($MyInvocation.MyCommand.Path)\.."))
Write-Host $ParentPath

# Get the current directory path
$CurrentPath = (Get-Item .).FullName
Write-Host $CurrentPath
```

## 6. Start a process in background

```shell
# Start a Java application in background
Start-Process javaw -ArgumentList "-Dlog4j.configurationFile=log4j2.properties",
        "-jar",
        "app.jar",
        "--spring.config.location=\config\" -WindowStyle Hidden

# Start a Python application in background
Start-Process -FilePath "python" -ArgumentList "$PythonScript" -RedirectStandardError "$PathLogErr" -WindowStyle Hidden

# Run exe file
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$InstallerFilePath`" /qn INSTALLDIR=`"$InstallDir`" /passive" -Wait -Verb RunAs

# Run msi installer file
Start-Process msiexec -Wait -ArgumentList "/i `"$InstallerFilePath`" /passive ADDLOCAL=`"all`""
```

## 7. Expand Archive File

```shell
Expand-Archive -Path $ZipFilePath -DestinationPath $DirPath -Force:True
```

## 8. Set timezone

```shell
Set-TimeZone -Id "Tokyo Standard Time"
```

### 9. Remove item

```shell
# Remove all files from the folder
Remove-Item -LiteralPath "parentFolder/childFolder" -Force -Recurse

# Clean all files by extensions
Get-ChildItem -Path $ServicePath -Include *.jar,*.war,*.pyc -Recurse | Remove-Item
```
