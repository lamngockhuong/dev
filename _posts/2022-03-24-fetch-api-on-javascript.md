---
title: Fetch API on Javascript
author: lamngockhuong
date: 2022-03-24 18:15:00 +0700
categories: [Javascript]
tags: [javascript, fetchapi]
image:
  path: /posts/2023/10/js.png
  width: 800
  height: 500
---
## POST method

```javascript
async function postData(url = '', data = {}) {
  // Default options are marked with *
  const response = await fetch(url, {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    mode: 'cors', // no-cors, *cors, same-origin
    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
    credentials: 'same-origin', // include, *same-origin, omit
    headers: {
      'Content-Type': 'application/json'
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
    redirect: 'follow', // manual, *follow, error
    referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
    body: JSON.stringify(data) // body data type must match "Content-Type" header
  });
  return response.json(); // parses JSON response into native JavaScript objects
}

postData('https://jsonplaceholder.typicode.com/posts', {
    answer: 42
  })
  .then(data => {
    console.log(data); // JSON data parsed by `data.json()` call
  });
```

## GET method

```javascript
async function getData(url = '') {
  const response = await fetch(url, {
    method: 'GET',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json'
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
  });
  return response.json();
}

getData('https://jsonplaceholder.typicode.com/posts')
  .then(data => {
    console.log(data);
  });
```

👉 [Demo](https://jsfiddle.net/lamngockhuong/3amdq42x/)

## References

+ [Using the Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch)
