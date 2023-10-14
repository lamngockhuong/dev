---
title: Converting text to speech with Javascript
author: lamngockhuong
date: 2022-03-22 08:10:00 +0700
categories: [Javascript]
tags: [javascript]
image:
  path: /posts/2023/10/js.png
  width: 800
  height: 500
---
## API Web Speech & Demo

```javascript
function speak (message) {
   var msg = new SpeechSynthesisUtterance(message)
   var voices = window.speechSynthesis.getVoices()
   msg.voice = voices[0]
   window.speechSynthesis.speak(msg)
}

speak('Hello. I am Khuong')
```

👉 [Demo](https://jsfiddle.net/lamngockhuong/ubt9qjgr/)

## References

+ [SpeechSynthesisUtterance](https://developer.mozilla.org/en-US/docs/Web/API/SpeechSynthesisUtterance)
