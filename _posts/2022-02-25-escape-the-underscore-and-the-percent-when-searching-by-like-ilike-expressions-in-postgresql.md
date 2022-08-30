---
title: Escape the underscore and the percent when searching by like, ilike expressions in PostgreSQL
author: lamngockhuong
date: 2022-02-25 10:10:00 +0700
categories: [Javascript]
tags: [javascript, sql, postgresql]
---

To escape the underscore and the percent to be used in a pattern in like expressions use the escape character (`\`):
```sql
SELECT * FROM users WHERE name LIKE '\_';
SELECT * FROM users WHERE name LIKE '\%';

SELECT * FROM users WHERE name ILIKE '\_';
SELECT * FROM users WHERE name ILIKE '\%';
```

In JS, you can use `regex` and `replace function` to prepare keyword string:
```javascript
const keyword = keywordFromInput.trim().replace(/([_%\\])/g, '\\$1');
```
