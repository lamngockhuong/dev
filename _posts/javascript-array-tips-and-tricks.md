---
title: Javascript Array tips and tricks
author:
  name: Lam Ngoc Khuong
  link: https://github.com/lamngockhuong
date: 2022-03-21 12:10:00 +0700
categories: [Javascript]
tags: [javascript, array, tips, tricks]
---

## 1. Remove duplicates value from an array
```javascript
const languages = ['java', 'php', 'ruby', 'python', 'php', 'python'];
console.log(languages);

// First method
const uniqueLangs = Array.from(new Set(languages));
console.log(uniqueLangs);

// Second method
const uniqueLangs2 = [...new Set(languages)];
console.log(uniqueLangs2);
```
Demo: https://jsfiddle.net/lamngockhuong/fxdvLsh4/9/

## References
