---
title: NodeJS memory usage check
author: lamngockhuong
date: 2022-08-31 13:25:00 +0700
categories: [NodeJS]
tags: [nodejs, memory]
---
## NodeJS
### Checking memory usage

```javascript
const makeReadable = (value: number): string =>
  `${Math.round((value / 1024 / 1024) * 100) / 100} MB`;

export const memoryUsage = (): string => {
  const used = process.memoryUsage();

  let usage = 'Memory usage >> ';
  for (const [key, value] of Object.entries(used)) {
    usage += `${key}: ${makeReadable(value)}, `;
  }

  return usage;
};
```