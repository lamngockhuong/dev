---
title: Timing Attack: A Hidden Risk When Comparing Secrets
description: Learn why comparing API keys or signatures using === is insecure, and how a simple timing attack can expose your secrets. Includes a clear example in TypeScript and how to fix it using constant-time comparison.
author: lamngockhuong
date: 2025-07-07 17:45:00 +0700
categories: [Security]
tags: [javascript, security, timing attack, api keys, tokens, signatures, constant time comparison]
image:
  path: /posts/2025/07/security.png
  width: 800
  height: 500
---

Many developers compare API keys, tokens, or webhook signatures like this:

```ts
if (apiKey === expectedKey) { ... }
```

This looks fine, but it's actually **unsafe**.

---

## What’s the Problem?

Normal string comparison (like `===`) stops at the first mismatch. That means:

* More correct characters → longer comparison time
* Hackers can measure the time to **guess your API key, token, or signature one character at a time**

This is called a **timing attack**.

---

## How to Fix It

Use **constant-time comparison**, which takes the same time no matter how similar the strings are.

For example, in Node.js:

```ts
import { timingSafeEqual } from 'crypto';

const a = Buffer.from(signature);
const b = Buffer.from(expectedSignature);

if (a.length !== b.length || !timingSafeEqual(a, b)) {
  throw new Error('Invalid signature');
}
```

Other languages:

| Language | Safe Compare Function                 |
| -------- | ------------------------------------- |
| Node.js  | `crypto.timingSafeEqual()`            |
| Python   | `hmac.compare_digest()`               |
| Java     | `MessageDigest.isEqual()`             |
| Go       | `crypto/subtle.ConstantTimeCompare()` |

---

## Demo in TypeScript

```ts
function sleep(ms: number) {
  const start = Date.now();
  while (Date.now() - start < ms);
}

function insecureCompare(a: string, b: string): boolean {
  if (a.length !== b.length) return false;
  for (let i = 0; i < a.length; i++) {
    if (a[i] !== b[i]) return false;
    sleep(5); // Simulate delay
  }
  return true;
}

function guessSecret(real: string, charset: string): string {
  let guessed = '';
  while (guessed.length < real.length) {
    let bestChar = '';
    let maxTime = 0;

    for (const ch of charset) {
      const tryGuess = guessed + ch + 'a'.repeat(real.length - guessed.length - 1);
      const t0 = performance.now();
      insecureCompare(tryGuess, real);
      const t1 = performance.now();
      if (t1 - t0 > maxTime) {
        maxTime = t1 - t0;
        bestChar = ch;
      }
    }

    guessed += bestChar;
    console.log(`Guessed: ${guessed}`);
  }
  return guessed;
}

const realKey = 'abc1';
guessSecret(realKey, 'abcdefghijklmnopqrstuvwxyz0123456789');
```

Play it on [Typescript Playground](https://l.khuong.dev/typescript-play-timing-attack)

---

## Summary

* Use constant-time comparison for **API keys, tokens, HMAC signatures**
* Don’t use `===` or simple string comparison
* One mistake could let attackers **guess your secrets**
