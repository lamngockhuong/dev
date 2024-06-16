---
title: The helpful Git Aliases
author: lamngockhuong
date: 2024-06-16 19:00:00 +0700
categories: [Git]
tags: [git, tips]
image:
  path: /posts/2023/10/git.png
  width: 800
  height: 500
---

```bash
# git log -1 HEAD
# => git last
git config --global alias.last 'log -1 HEAD'

# git reset HEAD -- fileA
# => git unstage fileA
git config --global alias.unstage 'reset HEAD --'

# git checkout develop
# => git co develop
git config --global alias.co checkout

# git branch
# => git br
git config --global alias.br branch

# git commit -m "msg"
# => git ci -m "msg"
git config --global alias.ci commit

# git status
# => git st
git config --global alias.st status

# git commit --amend --no-edit
# => git cia
git config --global alias.cia 'commit --amend --no-edit'

# git push origin HEAD
# => git poh
git config --global alias.poh 'push origin HEAD'
```