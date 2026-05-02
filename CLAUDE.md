# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal tech blog ("Khuong Dev Notebook") built with Jekyll using the [Chirpy theme](https://github.com/cotes2020/jekyll-theme-chirpy) (v7.3+). Deployed to GitHub Pages at `dev.ngockhuong.com` via Cloudflare. Content is developer notes and tutorials.

## Commands

```bash
# Install dependencies
bundle install

# Local dev server (live reload)
bundle exec jekyll s -l

# Production mode locally
bash tools/run.sh -p

# Build for production
JEKYLL_ENV=production bundle exec jekyll b -d _site

# Build + test (html-proofer, internal links only)
bash tools/test.sh
```

## Architecture

- **Theme**: `jekyll-theme-chirpy` gem - layouts, includes, and assets come from the gem, not this repo
- **Posts**: `_posts/` - Markdown files named `YYYY-MM-DD-slug.md` with YAML front matter
- **Tabs**: `_tabs/` - Top-level pages (about, archives, categories, tags) ordered via `order` front matter
- **Data**: `_data/` - `authors.yml`, `contact.yml`, `share.yml` consumed by theme layouts
- **Plugin**: `_plugins/posts-lastmod-hook.rb` - Auto-sets `last_modified_at` from git log on posts with >1 commit
- **Images**: Stored in separate repo (`lamngockhuong/dev-images`), served via CDN configured in `_config.yml` (`cdn` key). Local `assets/img/` only has favicons
- **CI/CD**: `.github/workflows/pages-deploy.yml` - builds with Ruby 3.3, runs html-proofer, deploys to GitHub Pages, then purges Cloudflare cache

## Writing Posts

Posts use Chirpy front matter conventions:

```yaml
---
title: "Post Title"
date: YYYY-MM-DD HH:MM:SS +0700
categories: [Category, Subcategory]
tags: [tag1, tag2]
---
```

- Permalink pattern: `/posts/:title/`
- Comments via Giscus (auto-enabled for all posts)
- TOC enabled globally
- Images referenced with `/path/from/cdn-root` - the CDN prefix is prepended automatically

## Key Config Notes

- `_config.yml` `cdn` field points to the raw GitHub URL for the `dev-images` repo
- Analytics: GoatCounter (`khuongdev`)
- Page views provider: GoatCounter
- PWA enabled with offline cache
- `baseurl` is empty (root domain deployment)
