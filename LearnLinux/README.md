# 🧰 Learn Linux: Command Cheat Sheet
 
The essential Linux commands, organised by skill, with notes to help you get started or refresh your memory.
 
> 🎮 **Want to practise?** These are exactly the skills the [OverTheWire Bandit guide](../OTW2026/README.md) puts to work.
 
> 💡 **Golden rule:** when you meet a new command, run `man <command>` or `<command> --help`.
 
---
 
## 📚 Table of Contents
 
1. [File System Navigation](#1-file-system-navigation)
2. [Permissions and Ownership](#2-permissions-and-ownership)
3. [Text Processing (grep, awk, sed)](#3-text-processing-grep-awk-sed)
4. [Process Management](#4-process-management)
5. [Networking & Encoding Extras](#5-networking--encoding-extras)
6. [Resources](#-resources)
**Key skills gained:** ✅ File system navigation ✅ Permissions and ownership ✅ Text processing (grep, awk, sed) ✅ Process management
 
---
 
## 1. File System Navigation
 
| Command | What it does | Example |
|---|---|---|
| `pwd` | Print where you are | `pwd` |
| `ls` | List files | `ls -la` (long format, including hidden files) |
| `cd` | Change directory | `cd /tmp`, `cd ..`, `cd ~`, `cd -` |
| `cat` | Print a file's contents | `cat readme` |
| `less` | Scroll through a long file (`q` to quit) | `less bigfile.txt` |
| `file` | Identify what kind of data a file holds | `file ./*` |
| `find` | Search for files by name, size, owner, type… | `find . -type f -size 1033c` |
| `du` | Show disk usage / file sizes | `du -b somefile` |
| `mkdir` / `mktemp -d` | Make a directory / make a unique temp directory | `mktemp -d` |
| `cp` / `mv` / `rm` | Copy / move or rename / delete | `cp data.txt /tmp/work/` |
| `touch` | Create an empty file | `touch notes.txt` |
 
**Helpful notes**
 
- **Paths:** `/` is the root, `~` is your home, `.` is here, `..` is one level up. Absolute paths start with `/`; relative paths don't.
- **Hidden files** start with a dot (`.bashrc`). Plain `ls` won't show them; use `ls -a`.
- **Awkward filenames:**
  - A file called `-` is read as an option. Use a path: `cat ./-`
  - Spaces need quotes or escapes: `cat "my file"` or `cat my\ file`
  - Tab completion handles the escaping for you. Use it constantly.
- **`find` flags worth knowing:**
  - `-name "*.txt"` (by name), `-type f` / `-type d` (files / directories)
  - `-size 33c` (exactly 33 bytes; `c` = bytes), `-size +1M` (bigger than 1 MB)
  - `-user NAME`, `-group NAME`, `! -executable`
- **Silence the noise:** hide "Permission denied" errors by sending stderr to nowhere:
```bash
  find / -user someuser 2>/dev/null
```
- **Redirection:** `>` writes to a file (overwrites), `>>` appends, `2>` redirects errors.
---
 
## 2. Permissions and Ownership
 
Reading the output of `ls -l`:
 
```
-rwsr-x--- 1 alice staff 14876 Oct 14 12:00 program
│└┬┘└┬┘└┬┘   └─┬─┘ └─┬─┘
│ │  │  │    owner  group
│ │  │  └── others: no permissions
│ │  └───── group:  read, execute
│ └──────── owner:  read, write, setuid (s)
└────────── file type (- file, d directory, l link)
```
 
| Command | What it does | Example |
|---|---|---|
| `ls -l` | Show permissions, owner, group | `ls -l` |
| `chmod` | Change permissions | `chmod 600 key.private`, `chmod +x script.sh` |
| `chown` | Change owner (usually needs root) | `chown user:group file` |
| `id` / `whoami` | Who am I, and which groups am I in? | `id` |
| `stat` | Detailed file info | `stat file` |
| `sudo` | Run a command as root (if allowed) | `sudo apt update` |
 
**Helpful notes**
 
- Permission numbers: `r = 4`, `w = 2`, `x = 1`, added per group. So `7 = rwx`, `6 = rw-`, `5 = r-x`, `4 = r--`.
  - `chmod 755 file` → owner `rwx`, group `r-x`, others `r-x`
  - `chmod 600 file` → owner `rw-`, nobody else anything
- On **directories**, `x` means "can enter", `r` means "can list".
- **setuid (`s`)**: a program with this bit runs with the **file owner's** permissions, not yours.
- **SSH private keys** must be private or SSH refuses them: `chmod 600 key.private`.
---
 
## 3. Text Processing (grep, awk, sed)
 
| Command | What it does | Example |
|---|---|---|
| `grep` | Find lines matching a pattern | `grep "error" log.txt` |
| `sort` | Sort lines | `sort data.txt` |
| `uniq` | Filter repeated **adjacent** lines | `sort data.txt \| uniq -u` |
| `strings` | Pull readable text out of binary files | `strings binfile` |
| `wc` | Count lines / words / bytes | `wc -l data.txt` |
| `head` / `tail` | First / last lines of a file | `tail -n 5 file`, `tail -f log` |
| `diff` | Compare two files | `diff old.txt new.txt` |
| `cut` | Pull out columns | `cut -d: -f1 /etc/passwd` |
| `tr` | Translate or replace characters | `tr 'a-z' 'A-Z'` |
| `base64` | Encode / decode base64 | `base64 -d data.txt` |
| `awk` | Process columns / fields | `awk '{print $2}' file` |
| `sed` | Find-and-replace in a stream | `sed 's/old/new/g' file` |
 
**Pipes (`|`) are where it clicks.** Each command does one small job; chain them together:
 
```bash
sort data.txt | uniq -c | sort -n      # count occurrences, least to most common
strings binfile | grep "=="            # readable text containing "=="
ps aux | grep python                   # find python processes
```
 
**`grep` quick reference**
- `-i` ignore case · `-v` invert (non-matching lines) · `-r` recursive · `-n` line numbers · `-c` count · `-E` extended regex
**`awk` quick reference**
```bash
awk '{print $1}' file              # first column (space separated)
awk -F: '{print $1}' /etc/passwd   # use ':' as the separator
awk '$3 > 100' file                # rows where column 3 > 100
awk 'length($0) > 20' file         # lines longer than 20 chars
```
 
**`sed` quick reference**
```bash
sed 's/cat/dog/' file      # replace first 'cat' on each line
sed 's/cat/dog/g' file     # replace every 'cat'
sed -n '5p' file           # print only line 5
sed '/^$/d' file           # delete empty lines
sed -i 's/a/b/g' file      # edit the file in place (careful!)
```
 
**Regex basics:** `^` start of line · `$` end of line · `.` any character · `*` zero or more · `[0-9]` any digit · `[A-Za-z]` any letter
 
---
 
## 4. Process Management
 
| Command | What it does | Example |
|---|---|---|
| `ps` | List running processes | `ps aux` |
| `top` / `htop` | Live process view | `top` |
| `kill` | Stop a process by PID | `kill 1234`, `kill -9 1234` |
| `pkill` | Stop processes by name | `pkill firefox` |
| `jobs` / `fg` / `bg` | Manage jobs in your shell | `jobs`, `fg %1` |
| `&` | Run a command in the background | `long_task &` |
| `Ctrl + C` / `Ctrl + Z` | Stop / pause the foreground process | |
| `crontab -l` / `-e` | List / edit your scheduled jobs | `crontab -l` |
 
**Helpful notes**
 
- Every process has a **PID** (process ID) and runs **as a user**. `ps aux` shows both.
- `kill` sends a polite stop signal (`SIGTERM`); `kill -9` forces it (`SIGKILL`). Try the polite one first.
- **Cron** runs commands on a schedule. System cron configs live in `/etc/cron.d/`.
- Cron timing format: `minute hour day month weekday`
```
  * * * * *      every minute
  0 9 * * 1-5    9am on weekdays
  */15 * * * *   every 15 minutes
```
- Run a command on a remote machine without an interactive shell:
```bash
  ssh user@host "ls -la"
```
 
---
 
## 5. Networking & Encoding Extras
 
| Command | What it does | Example |
|---|---|---|
| `ssh` | Remote login | `ssh -i key.private user@host -p 2220` |
| `scp` | Copy files over SSH | `scp -P 2220 user@host:file .` |
| `nc` (netcat) | Read/write raw network connections | `nc localhost 30000` / `nc -l 4444` |
| `openssl s_client` | Talk to an SSL/TLS service | `openssl s_client -connect host:443` |
| `nmap` | Scan for open ports | `nmap -p 1-1000 localhost` |
| `xxd` | Make or reverse a hex dump | `xxd file`, `xxd -r dump.hex out.bin` |
| `gzip` / `bzip2` / `tar` | Decompress / unpack archives | `gzip -d f.gz`, `bzip2 -d f.bz2`, `tar -xf f.tar` |
| `git` | Version control | `git clone`, `git log`, `git branch -a`, `git tag` |
 
> ⚠️ Only scan or probe machines you own or have permission to test.
 
---
 
## 🔗 Resources
 
- [explainshell.com](https://explainshell.com/): paste any command to see what each part does
- [The Linux Command Line (free book)](https://linuxcommand.org/tlcl.php)
- [Regex101](https://regex101.com/): test your `grep`/`sed` patterns
- [crontab.guru](https://crontab.guru/): decode cron schedules
- `man <command>`: the original and still the best
