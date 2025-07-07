---
title: Suppress Startup log in NestJS
author: lamngockhuong
date: 2022-04-12 09:00:00 +0700
categories: [Frameworks & Libraries, NestJS]
tags: [nestjs, javascript, typescript, log]
image:
  path: /posts/2023/10/nodejs.png
  width: 800
  height: 500
---
## Example

```typescript
// main.ts

import { NestFactory } from  '@nestjs/core';
import { AppModule } from  './app.module';
import { bootstrapLogger } from './bootstrap-logger';
...
const app = await NestFactory.create(AppModule, {
  logger: bootstrapLogger(),
});
...
```

```typescript
// bootstrap-logger.ts

import { Format } from 'logform';
import { WinstonModule } from 'nest-winston';
import { format, transports } from 'winston';
import { customConsoleFormat } from './customConsole';

export const bootstrapLogger = () => {
  const customFormat: Format = customConsoleFormat();

  const suppressStartupLog = format(info => {
    if (
      info.level === 'info' &&
      (info.context === 'InstanceLoader' ||
        info.context === 'RoutesResolver' ||
        info.context === 'RouterExplorer')
    ) {
      return false;
    }
    return info;
  });

  const transport = new transports.Console({
    level: 'DEBUG',
    format: format.combine(suppressStartupLog(), customFormat),
  });

  return WinstonModule.createLogger({ transports: [transport] });
};
```

```typescript
// custom-console.ts

import { format } from 'winston';

export const customConsoleFormat = (moduleName?: string) =>
  format.printf(({ context, level, timestamp, message, ..._meta }) => {
    return (
      ('undefined' !== typeof moduleName ? `[${moduleName}]  ` : '') +
      `${level.charAt(0).toUpperCase() + level.slice(1)}  ` +
      ('undefined' !== typeof timestamp ? `${new Date(timestamp).toISOString()}  ` : '') +
      ('undefined' !== typeof context ? `(${context})  ` : '') +
      message
    );
  });
```
