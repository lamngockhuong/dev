---
title: Promise allSettled vs Promise all
author: lamngockhuong
date: 2024-04-09 13:15:00 +0700
categories: [Javascript]
tags: [javascript, promise]
image:
  path: /posts/2023/10/js.png
  width: 800
  height: 500
---

## Promise all

```javascript
Promise.all([
    Promise.reject('✗'),
    Promise.reject('✗'),
    Promise.resolve('✓'),
    Promise.reject('✗'),
]).catch((err) => {
     console.log('You win at life', err);
})
```

`Promise all` will reject as soon as there is a Promise in the Array returned to `reject`.


Result:
```
You win at life ✗
```

## Promise allSettled

```javascript
Promise.allSettled([
    Promise.reject('✗'),
    Promise.reject('✗'),
    Promise.resolve('✓'),
    Promise.reject('✗'),
]).then(function(value) {
    console.log(`You win at life`, value)
})
```

`Promise allSettled` will run all Promises in the array, regardless of whether they return `rejected` or `fulfilled`

Result:
```
You win at life,
[
    {
        status:"rejected",
        reason:"✗"
    },
    {
        status:"rejected",
        reason:"✗"
    },
    {
        status:"fulfilled",
        value:"✓"
    },
    {
        status:"rejected",
        reason:"✗"
    }
]
```
