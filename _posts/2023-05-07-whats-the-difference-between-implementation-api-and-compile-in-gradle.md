---
title: What's the difference between implementation, api and compile in Gradle?
author: lamngockhuong
date: 2023-05-07 15:45:00 +0700
categories: [Gradle]
tags: [implementation, api, compile, compileOnly, runtimeOnly, testImplementation, testCompileOnly, testRuntimeOnly]
---

## Gradle

What's the difference between implementation, api and compile (compileOnly, runtimeOnly, testImplementation, testCompileOnly, testRuntimeOnly) in Gradle?

| Name               | Role                                     | Consumable? | Resolveable? | Description                             |
|--------------------|------------------------------------------|-------------|--------------|-----------------------------------------|
| api                |Declaring<br/>API<br/>dependencies                |      no     |      no      | This is where you should declare<br/>dependencies which are transitively<br/>exported to consumers, for compile.|
| implementation     |Declaring<br/>implementation<br/>dependencies     |      no     |      no      | This is where you should<br/>declare dependencies which are<br/>purely internal and not<br/>meant to be exposed to consumers.|
| compileOnly        |Declaring<br/>compileOnly<br/>dependencies        |      yes    |      yes     | This is where you should<br/>declare dependencies<br/>which are only required<br/>at compile time, but should<br/>not leak into the runtime.<br/>This typically includes dependencies<br/>which are shaded when found at runtime.|
| runtimeOnly        | Declaring<br/>runtime<br/>dependencies           |      no     |      no      | This is where you should<br/>declare dependencies which<br/>are only required at runtime,<br/>and not at compile time.|
| testImplementation | Test<br/>dependencies                        |      no     |      no      | This is where you<br/>should declare dependencies<br/>which are used to compile tests.|
| testCompileOnly    | Declaring test<br/>compile only<br/>dependencies |      yes    |      yes     | This is where you should<br/>declare dependencies<br/>which are only required<br/>at test compile time,<br/>but should not leak into the runtime.<br/>This typically includes dependencies<br/>which are shaded when found at runtime.|
| testRuntimeOnly    | Declaring test<br/>runtime dependencies      |      no     |      no      | This is where you should<br/>declare dependencies which<br/>are only required at test<br/>runtime, and not at test compile time.|

## References

+ [https://stackoverflow.com/a/55593434](https://stackoverflow.com/a/55593434)
