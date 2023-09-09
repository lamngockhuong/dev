---
title: Change the default Java (JDK) version on macOS
author: lamngockhuong
date: 2023-06-25 13:05:00 +0700
categories: [Java]
tags: [java, jdk, macos]
---

First run `/usr/libexec/java_home -V` to check available Java Virtual Machine:

```bash
Matching Java Virtual Machines (2):
20.0.1 (arm64) "Eclipse Adoptium" - "OpenJDK 20.0.1" /Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home
17.0.7 (arm64) "Eclipse Adoptium" - "OpenJDK 17.0.7" /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
/Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home
```

## Change the default Java (JDK) version

Pick the version you want to be the default (20.0.1) then:

`export JAVA_HOME="/usr/libexec/java_home -v 20.0.1"`

Now when you run `java -version` you will see:

```bash
openjdk version "20.0.1" 2023-04-18
OpenJDK Runtime Environment Temurin-20.0.1+9 (build 20.0.1+9)
OpenJDK 64-Bit Server VM Temurin-20.0.1+9 (build 20.0.1+9, mixed mode)
```

Add the

```bash
export JAVA_HOME="/usr/libexec/java_home -v 20.0.1"

```

line to your shell’s init file.

Updating the .zshrc file should work:

```bash
nano ~/.zshrc

```

paste the line

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 20.0.1)

```

at bottom of the file.

Press `CTRL+X` to exit the editor, Press **Y** to save your changes.

```bash
source ~/.zshrc
echo $JAVA_HOME
java -version
```

## Fast switch between different JDK versions

1. Add the below function in your `~/.bashrc` or `~/.zshrc`

```bash
jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        java -version
 }
```

2. Source the profile and you can change the version like below:

```bash
 jdk 17
 jdk 20
```

## References

- <https://dev.to/rithvik78/change-the-default-java-version-on-macos-3jee>
- <https://github.com/AdoptOpenJDK/homebrew-openjdk#adoptopenjdk---homebrew-tap>
