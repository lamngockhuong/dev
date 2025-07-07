---
title: UUID in NodeJS
author: lamngockhuong
date: 2022-03-23 21:25:00 +0700
categories: [Programming Languages, NodeJS]
tags: [javascript, uuid, nodejs]
image:
  path: /posts/2023/10/js.png
  width: 800
  height: 500
---

## UUID (Universally Unique IDentifier)

`crypto` - Module was added from Node.js 14.17.0

```javascript
const  crypto  =  require("crypto");
console.log(crypto.randomUUID());
```

`uuid` module:

```javascript
const  uuid  =  require("uuid");
console.log(`Here is a test v1 uuid: ${uuid.v1()}`);
console.log(`Here is a test v4 uuid: ${uuid.v4()}`);
```

`nanoid` module:

```javascript
const  Nanoid  =  require("nanoid");
const  NanoidAsync  =  require("nanoid/async");
console.log(`UUID with Nano ID sync: ${Nanoid.nanoid()}`);
(async  function  ()  {
const  nanoId  =  await  NanoidAsync.nanoid();
console.log(`UUID with Nano ID async: ${nanoId}`);
})();
```

👉 [Demo](https://codesandbox.io/s/lamngockhuong-nodejs-o9jipq?file=/uuid.js)
