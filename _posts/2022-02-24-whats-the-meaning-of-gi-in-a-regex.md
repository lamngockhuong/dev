---
title: What's the meaning of /gi in a regex?
author:
  name: Lam Ngoc Khuong
  link: https://github.com/lamngockhuong
date: 2022-02-24 17:10:00 +0700
categories: [Javascript]
tags: [javascript, regex]
---

    g modifier: global. All matches (don't return on first match)

    i modifier: insensitive. Case insensitive match (ignores case of [a-zA-Z])

In your case though `i` is immaterial as you don't capture `[a-zA-Z]`.

For input like `!@#$` if `g` modifier is not there regex will return first match `!` [**See here**](https://regex101.com/r/sH8aR8/55).

If `g` is there it will return the whole or whatever it can match [**See here**](https://regex101.com/r/sH8aR8/56).

## References
- https://stackoverflow.com/a/27916097/5718493
- [JavaScript RegExp gi Modifier](https://w3schools.sinsixx.com/jsref/jsref_regexp_modifier_gi.asp.htm#:~:text=The%20gi%20modifier%20is%20used,regular%20expression%20in%20a%20string.)
