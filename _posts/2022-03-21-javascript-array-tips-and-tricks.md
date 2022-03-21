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

## 3. Create a new array with the sub-array elements concatenated into it
Using: `flat()` & `flat(depth)` ([Refer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat))
```javascript
// Ex1:
const arr1 = [0, 1, 2, [3, 4]];
console.log(arr1.flat());
console.log(arr1.reduce((acc, val) => acc.concat(val), [])); // equivalent to flat
console.log([].concat.apply([], arr1)); // equivalent to flat
// Expected output: [0, 1, 2, 3, 4]

// Ex2:
const arr2 = [0, 1, 2, [[[3, 4]]]];
console.log(arr2.flat(2)); // Expected output: [0, 1, 2, [3, 4]]
```
👉 [Demo 3](https://jsfiddle.net/lamngockhuong/g3hdjxsw/)

## 4. Find max/min value in an array

```javascript
let numbers = [50, 300, 400, 1500];
 
let min = Math.min(...numbers);
console.log(min); // 80
 // Or
min = Math.min.apply(null, numbers);
console.log(min); // 80

let max = Math.max(...numbers);
console.log(max); // 80
// Or
max = Math.max.apply(null, numbers);
console.log(max); // 80
```
👉 [Demo 4](https://jsfiddle.net/lamngockhuong/jgzfwe3p/)

### Updating...
