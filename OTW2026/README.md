# 🐧 OverTheWire: Bandit Guide (OTW2026)
 
A beginner-friendly guide to working through the [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) wargame, plus the shell scripts I wrote to automate the levels.
 
> **No spoilers here.** This guide gives hints, approaches and the commands worth learning, **not passwords or copy-paste answers**. OverTheWire asks players not to publish solutions, and you'll learn far more by working each level out yourself.
 
> 📘 **New to Linux, or need a refresher?** The command cheat sheet lives in [`../learnlinux`](../learnlinux/README.md). Keep it open alongside this guide.
 
---
 
## 📚 Table of Contents
 
1. [What You'll Learn](#-what-youll-learn)
2. [Getting Started](#-getting-started)
3. [Level-by-Level Hints](#-level-by-level-hints)
4. [Scripts in This Directory](#-scripts-in-this-directory)
5. [Tips for Getting Unstuck](#-tips-for-getting-unstuck)
---
 
## 🎯 What You'll Learn
 
| Skill | Where it shows up in Bandit | Cheat sheet section |
|---|---|---|
| ✅ **File system navigation** | Hidden files, odd filenames, searching the whole system | [Navigation](../learnlinux/README.md#1-file-system-navigation) |
| ✅ **Permissions and ownership** | Files by owner/group, setuid binaries, SSH keys | [Permissions](../learnlinux/README.md#2-permissions-and-ownership) |
| ✅ **Text processing (grep, awk, sed)** | Pulling one line out of thousands, sorting, decoding | [Text processing](../learnlinux/README.md#3-text-processing-grep-awk-sed) |
| ✅ **Process management** | Running commands over SSH, setuid programs | [Processes](../learnlinux/README.md#4-process-management) |
 
---
 
## 🚀 Getting Started
 
### 1. Connect to the game
 
```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
 
- **Host:** `bandit.labs.overthewire.org`
- **Port:** `2220` (not the default 22, so don't forget `-p`)
- **Level 0 password:** `bandit0`
### 2. How the game works
 
- Each level's goal is to find the **password for the next level**.
- Once you have it, `exit` and log in as the next user, e.g. `bandit1`.
- Read the **level page** on the OverTheWire site every time: it tells you where the password is and lists commands that may help.
### 3. Keep your own notes
 
Store passwords in a **local** file that never gets committed (see [Scripts](#-scripts-in-this-directory)). Write down *how* you solved each level too; that's the part worth revisiting.
 
---
 
## 🗺️ Level-by-Level Hints
 
Small nudges only, covering **levels 0 → 20**. Try the level page first and peek here only when stuck.
 
> 📖 Want the full explanation for a level? See the [detailed walkthrough](./WALKTHROUGH.md).
 
<details>
<summary><b>Levels 0 → 6 · File system navigation</b></summary>
| Level | Clue |
|---|---|
| 0 → 1 | Look around your home directory. |
| 1 → 2 | Some filenames look like options. |
| 2 → 3 | Spaces matter. |
| 3 → 4 | Not everything is visible by default. |
| 4 → 5 | What *type* of data is in each file? |
| 5 → 6 | `find` can filter by more than name. |
| 6 → 7 | Search everywhere, and silence the errors. |
 
</details>
<details>
<summary><b>Levels 7 → 12 · Text processing</b></summary>
| Level | Clue |
|---|---|
| 7 → 8 | Look for the word next to it. |
| 8 → 9 | Unique, but only after some order. |
| 9 → 10 | Humans can't read binary, but `strings` can. |
| 10 → 11 | A familiar encoding. |
| 11 → 12 | Rotate by 13. |
| 12 → 13 | Layers upon layers. Keep asking `file`. |
 
</details>
<details>
<summary><b>Levels 13 → 20 · Permissions, SSH & networking</b></summary>
| Level | Clue |
|---|---|
| 13 → 14 | No password, but a key. |
| 14 → 15 | Talk to a port. |
| 15 → 16 | Same, but encrypted. |
| 16 → 17 | Which port answers differently? |
| 17 → 18 | Spot the difference. |
| 18 → 19 | You don't need a shell to run a command. |
| 19 → 20 | Whose permissions does that binary run with? |
 
</details>
---
 
## 🤖 Scripts in This Directory
 
Shell scripts that automate logging in to each level and running the solution steps.
 
```
OTW2026/
├── README.md
├── scripts/
│   ├── connect.sh        # SSH into a level by number
│   └── levelXX.sh        # one script per level
├── .passwords            # LOCAL ONLY, never committed
└── .gitignore
```
 
### ⚠️ Keep passwords out of Git
 
The scripts need each level's password to log in, so make sure those never reach the repo:
 
```gitignore
# OTW2026/.gitignore
.passwords
*.pass
*.key
*.private
```
 
Load them at runtime instead of hard-coding them, e.g. from the local `.passwords` file (one password per line):
 
```bash
PASS=$(sed -n "$((LEVEL + 1))p" .passwords)
```
 
> Tip: SSH won't read a password from a pipe by default. Tools like `sshpass` (or `expect`) can supply it for automation. Fine for a practice wargame, but use SSH keys for anything real.
 
### Usage
 
```bash
cd OTW2026
chmod +x scripts/*.sh
./scripts/connect.sh 5      # log in as bandit5
```
 
---
 
## 🧭 Tips for Getting Unstuck
 
1. **Re-read the level description.** Every word is a clue (size, owner, port number…).
2. **Read the "commands you may need" list** on the level page, then their `man` pages.
3. **Break the problem down.** Get it working with one command, then chain with pipes.
4. **Use `/tmp`** for scratch work: `cd $(mktemp -d)`.
5. **Check permissions** with `ls -l` whenever something says "Permission denied". That's usually the lesson.
6. **Take notes on *how*, not just *what*.** The method is what sticks.
7. **Check the [cheat sheet](../learnlinux/README.md)** for the command you half-remember.
---
 
## 🔗 Resources
 
- [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/)
- [explainshell.com](https://explainshell.com/): paste any command to see what each part does
