---
title: How to set scroll direction of your mouse (reverse mouse wheel scroll)
author: lamngockhuong
date: 2023-09-06 09:45:00 +0700
categories: [Windows]
tags: [Windows 10, config, mouse]
---

## Guideline

To set the scroll direction of your mouse, do the following steps:

**Step 1:** Open **Windows PowerShell** in **Administrator Mode**. You can do this by going to **Start Menu**, type **PowerShell**, and click **Run as Administrator**.

**Step 2:** Copy the following code and paste it in the command line of Windows PowerShell:

```shell
$mode = Read-host "How do you like your mouse scroll (0 or 1)?"; Get-PnpDevice -Class Mouse -PresentOnly -Status OK | ForEach-Object { "$($_.Name): $($_.DeviceID)"; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$($_.DeviceID)\Device Parameters" -Name FlipFlopWheel -Value $mode; "+--- Value of FlipFlopWheel is set to " + (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$($_.DeviceID)\Device Parameters").FlipFlopWheel + "`n" }
```

The code above is one-liner PowerShell script. Copy-paste it as-is.

**Step 3:** It will ask how do you like your mouse to scroll.

Downward wheel motion makes the page...

    0 - Move up so you see contents below (Default Mode, Windows behavior)

    1 - Move down so you can see contents above (Natural Mode, Mac behavior, reverse mode)

Type the number that corresponds to your scroll preference.

**Step 4:** `Restart your computer`. Your settings will take effect after you restart.

In a nutshell, the script detects all your mouse devices that's registered in your device and sets the FlipFlopWheel registry key to the value you selected. The script makes it easy for you to do this without opening Windows Registry and searching the device ID of your mouse which is error prone and confusing.

## References

- [Jason Go's script](https://answers.microsoft.com/en-us/windows/forum/all/reverse-mouse-wheel-scroll/657c4537-f346-4b8b-99f8-9e1f52cd94c2)
- <https://www.windowscentral.com/how-reverse-scrolling-direction-windows-10>
