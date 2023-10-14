---
title: UUID in Javascript
author: lamngockhuong
date: 2022-03-22 08:30:00 +0700
categories: [Javascript]
tags: [javascript, uuid]
image:
  path: /posts/2023/10/js.png
  width: 800
  height: 500
---
## UUID (Universally Unique IDentifier)

```javascript
function uuid() {
  var temp_url = URL.createObjectURL(new Blob());
  var uuid = temp_url.toString();
  URL.revokeObjectURL(temp_url);
  return uuid.substr(uuid.lastIndexOf('/') + 1); // remove prefix (e.g. blob:null/, blob:www.test.com/, ...)
}

for (var i = 0; i < 10; ++i) {
  console.log(uuid());
}
```

👉 [Demo](https://jsfiddle.net/lamngockhuong/m90bw8yr/)

## References

+ [UUID](https://abhishekdutta.org/blog/standalone_uuid_generator_in_javascript.html)
