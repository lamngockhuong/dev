---
title: Javascript Array tips and tricks
author:
  name: Lam Ngoc Khuong
  link: https://github.com/lamngockhuong
date: 2022-03-21 11:40:00 +0700
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
👉 [Demo 1](https://jsfiddle.net/lamngockhuong/fxdvLsh4)

## 2. Replace the specific value in an array
Using:
`Array.splice(index, howmany, item1, ..., itemX)`
```javascript
const languages = ['java', 'php', 'ruby', 'python', 'php', 'python'];
console.log(languages);

languages.splice(0, 2, 'go', 'js', 'perl');
console.log(languages); // return ["go", "js", "perl", "ruby", "python", "php", "python"]
```
👉 [Demo 2](https://jsfiddle.net/lamngockhuong/pt2kxcqo/)

## References
