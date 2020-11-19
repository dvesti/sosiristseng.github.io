---
title: "Git Submodule" # Title of the blog post.
date: 2020-11-16T11:36:39+08:00 # Date of post creation.
categories: ["Git"]
tags: ["git submodule", "git", "dependabot"]
comments: false # Disable comment if false.
---

Adding others' Git repo(s) to your Git project.

<!--more-->

> When you add a submodule in Git, you don't add the code of the submodule to the main repository, you only add information about the submodule that is added to the main repository. And the submodules could be updated separately by respective origins.

Check out this [article by gitaarik](https://gist.github.com/gitaarik/8735255) for background knowledge.

## Adding a submodule

```bash
git submodule add ${GIT_URL} ${YOUR_PROJ}
```

## Update all submodules to the latest commit

From [StackOverflow](https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin/5828396#5828396)

```bash
git submodule update --remote --merge
```

## GitHub dependabot for auto detecting updates in Git submodules

`.github/dependabot.yml`

```yml
version: 2
updates:

  - package-ecosystem: "gitsubmodule"
    directory: "/"
    schedule:
      interval: "daily"
    labels:
    - "dependencies"
    - "automerge"
```
