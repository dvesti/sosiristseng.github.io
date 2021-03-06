---
title: "Pass arguments from text files"
date: 2020-10-21T17:24:21+08:00
tags: ["linux", "command line"]
categories: ["Linux"]
comment: false
---

Passing arguments to a command from a text file.

<!--more-->

Use `sed` and `xargs`.

For example, to install two lists of packages in Ubuntu:

```bash
cat list1.txt list2.txt | sed 's/#.*$//' | xargs sudo apt install
```

- `xargs` takes the output from `sed` as arguments to `apt`
- `sed 's/#.*$//'` filters out those lines after `#`. So the `list2.txt` can have comments like the following

```txt
# Comment

item1
item2  # A comment after an item
    item3  # indent supported
```
