---
title: Change Chrome's Default Language on macOS
description: "A quick Terminal trick to switch Chrome's UI language on macOS using the defaults command and any IETF language tag."
author: lamngockhuong
date: 2026-05-02 10:50:00 +0700
categories: [macOS, Productivity]
tags: [chrome, macos, terminal, i18n, language]
---

Chrome on macOS doesn't expose a UI language picker; it follows the system language. You can override it with one Terminal command.

## Check the Current Setting

```bash
defaults read com.google.Chrome AppleLanguages
```

If you see `The domain/default pair of (com.google.Chrome, AppleLanguages) does not exist`, it just means no override has been set yet.

## Set a New Language

Pass any [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag):

```bash
defaults write com.google.Chrome AppleLanguages '(vi-VN)'
```

Capitalization doesn't matter, macOS normalizes it. Restart Chrome and the menu switches immediately. A few favorites:

- `vi-VN`: Vietnamese
- `en-GB`: British English
- `fr-CA`: Canadian French
- `es-MX`: Mexican Spanish
- `ja-JP`: Japanese
- `zh-CN`: Simplified Chinese
- `zh-TW`: Traditional Chinese
- `ko-KR`: Korean
- `de-DE`: German
- `ru-RU`: Russian
- `pt-BR`: Brazilian Portuguese

## Verify

From Terminal:

```bash
defaults read com.google.Chrome AppleLanguages
```

Or from any page's DevTools console:

```js
window.navigator.language
```

## Revert

Run the same `defaults write` command with your preferred language, or delete the override entirely:

```bash
defaults delete com.google.Chrome AppleLanguages
```
