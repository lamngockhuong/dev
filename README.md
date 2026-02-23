# Khuong Dev Notebook

Personal tech blog at [dev.ngockhuong.com](https://dev.ngockhuong.com) — developer notes and tutorials.

Powered by [Jekyll][jekyll] with [Chirpy][chirpy-theme] theme (v7.4+). Deployed to GitHub Pages via Cloudflare.

## Setup

```bash
git clone https://github.com/lamngockhuong/dev.git
git submodule update --init --remote --recursive
bundle install
```

**Pull latest:**

```bash
git pull --recurse-submodules
```

## Running Locally

```bash
# Dev server with live reload
bundle exec jekyll s -l

# Production mode
bash tools/run.sh -p
```

Open [http://localhost:4000](http://localhost:4000) to view the site.

## Build & Test

```bash
# Build for production
JEKYLL_ENV=production bundle exec jekyll b -d _site

# Build + test (html-proofer)
bash tools/test.sh
```

For more details, see the [Jekyll documentation][jekyll].

## Sponsoring

If you like this blog and my content, please consider sponsoring it, and your support would be greatly appreciated.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/G2G5PYMVW)

## License

This work is published under [MIT][mit] License.

[jekyll]: https://jekyllrb.com/
[chirpy-theme]: https://github.com/cotes2020/jekyll-theme-chirpy/
[mit]: https://github.com/lamngockhuong/dev/blob/main/LICENSE
