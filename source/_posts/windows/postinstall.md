---
title: "Postinstall (Windows)"
date: 2020-10-21T17:45:10+08:00
tags: ["postinstall"]
categories: ["Windows"]
comments: false
---

Things to do after Windows installation.

<!--more-->

## Debloat scripts

[@Chris Titus](https://christitus.com/windows-10-scripts/)

```powershell
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JJ8R4')"
```

- Installs [Chocolatey 🍫](https://chocolatey.org/), a command-line interface (CLI) [package](https://chocolatey.org/packages) manager for Windows.
- Removes OneDrive, Indexing, Defender, and bloatware.

## Install packages

Via [Chocolatey 🍫](https://chocolatey.org/).

```powershell
cinst -y git --params '"/NoShellHereIntegration"'
cinst -y vscode gitkraken mingw powershell-core microsoft-windows-terminal nodejs-lts miniconda3 deluge googlechrome firefox vivaldi brave anydesk telegram microsoft-teams 7zip bandizip honeyview potplayer youtube-dl ffmpeg lavfilters crystaldiskinfo treesizefree directx vcredist-all adobereader typora marktext miktex pandoc pandoc-crossref
