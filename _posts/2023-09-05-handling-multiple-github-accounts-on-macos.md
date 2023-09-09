---
title: Handling multiple Github accounts on MacOS
author: lamngockhuong
date: 2023-09-05 15:00:00 +0700
categories: [Git]
tags: [git, github]
---

## Guideline

**1. Creating the SSH keys. For each SSH key pairs:**

Go ~/.ssh

Run: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

**2. Register your keys to the respective GitHub accounts.**

Follow these [steps](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/) to do so.

**3. Head back over to the SSH `config` file at `~/.ssh` and amend accordingly to:**

```
#user1 account
Host github.com-user1
   HostName github.com
   User git
   IdentityFile ~/.ssh/github-user1
   IdentitiesOnly yes

#user2 account
Host github.com-user2
   HostName github.com
   User git
   IdentityFile ~/.ssh/github-user2
   IdentitiesOnly yes
```

Replace `user1` or `user2` with your GitHub usernames/identification-handlers

**Example:**

```
Host github.com-lamngockhuong
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_rsa
   IdentitiesOnly yes

Host github.com-khuongln
   HostName github.com
   User git
   IdentityFile ~/.ssh/github_khuongln_id_rsa
   IdentitiesOnly yes
```

**4. Go ahead to git clone your respective repository**

```bash
git clone git@github.com-user1:user1/your-repo-name.git your-repo-name_user1
```

**Example:**

```bash
git clone git@github.com-khuongln:vndevteam/your-repo-name.git your-repo-name_vndevteam
# or
git clone git@github.com-lamngockhuong:lamngockhuong/dev.git
```

**5. Configure your git identity**

Open up local git config using `git config --local -e` and add:

```
[user]
   name = user1
     email = user1@gmail.com
```

**6. Ensure your remote url is in the right format e.g: `git@github.com-user1:user1/your-repo-name.git your-repo-name_user1`**

- You either run `git remote set-url origin git@github.com-user1:user1/your-repo-name.git your-repo-name_user1`
- Or amend your remote ssh-url in your local git config file:

```
[remote "origin"]
       url = git@github.com-user1:user1/your-repo-name.git
       fetch = +refs/heads/*:refs/remotes/origin/*
```

Now you can git actions (pull/push/fetch...etc) all you like!

## References

- <https://gist.github.com/Jonalogy/54091c98946cfe4f8cdab2bea79430f9>
