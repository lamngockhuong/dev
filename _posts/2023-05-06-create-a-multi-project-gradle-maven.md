---
title: Create a multi-project with Gradle/Maven
author: lamngockhuong
date: 2023-05-06 21:00:00 +0700
categories: [Gradle]
tags: [gradle, maven, java, kotlin]
---
## Gradle

(Groovy)

```txt
.
├── app
│   ...
│   └── build.gradle
└── settings.gradle
```
{: file="Project layout" }


```gradle
rootProject.name = 'basic-multiproject'
include 'app'
```
{: file="settings.gradle" }

```gradle
plugins {
    id 'application'
}

application {
    mainClass = 'com.example.Hello'
}
```
{: file="app/build.gradle" }

## References

+ [Structuring and Building a Software Component with Gradle](https://docs.gradle.org/current/userguide/multi_project_builds.html)
