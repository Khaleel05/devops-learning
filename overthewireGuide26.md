# OverTheWire: Bandit Notes
 
Connect to any level with:
 
```bash
ssh banditN@bandit.labs.overthewire.org -p 2220
```
 
---
 
## Level 0 → 1
 
**Password:** `6y2kwnwK6grgvwvpvLaa2T1cpFEKOhNR`
 
---
 
## Level 1 → 2
 
The file is named `-`. This causes trouble for `cat`, because `-` is read as "standard input" rather than a filename. The fix is to access the file through its path.
 
```bash
cat ./-
```
 
**Password:** `PK8fYLZg2hnHSz83plBL1iEPKdD3QToB`
 
---
 
## Level 2 → 3
 
The password is stored in a file with spaces in its name (and it starts with `--`, which looks like an option).
 
```bash
cat ./"--spaces in this filename--"
```
 
Quoting the name keeps the spaces together; the `./` stops it being read as an option.
 
**Password:** `7ZZ2LFrykP2zEyvBl4m3clcL7tGYJPME`
 
---
 
## Level 3 → 4
 
I needed to go into a directory called `inhere` and access a hidden file (a file starting with `.`). I used the `-a` option to see it.
 
```bash
ls -a inhere
cat inhere/...Hiding-From-You
```
 
**Password:** `xzTXq1rDJQVVAzdv5cHq1TQytTWufAMq`
 
---
 
## Level 4 → 5
 
The password is in one of the files in `inhere`. The only hint is that it's the only human-readable file, so I assumed it contained ASCII text.
 
My first attempt was brute force: opening each file one by one. It was too time-consuming, and if the directory had thousands of files it would be completely impractical.
 
I used the `file` command, which determines file types:
 
```bash
file inhere/*
```
 
This lists each file with its name and type. That works when there aren't many files, but what if there were a large number? Checking each line carefully would take ages. How can I find the file with the correct type automatically?
 
I need one line that does two jobs: one part decides **where to look**, the other decides **what to look for**.
 
**Job 1: locate files and run `file` on each**
- `find` walks a directory and outputs paths that match the criteria (e.g. `-type f` means regular files only).
- `-exec` is a `find` option that runs a command on each result. The placeholder `{}` stands for "the file just found".
- The `-exec` command must be terminated with `\;`.
**Job 2: keep only the lines you care about**
- A pipe (`|`) sends the output of one command to the input of the next.
- `grep` prints only the lines of its input that contain a given pattern.
**Key notes**
- A pipe needs a command on both sides.
- The command that does the locating (`find`) goes on the outside (the beginning), and the identifier (`file`) goes on the inside.
- Shape of the command:
```
  find [where to look] [criteria] -exec [command to run] {} \;
```
- `{}` sits where the filename would normally go in the command.
The best command for this level:
 
```bash
find inhere -type f -exec file {} \; | grep "ASCII"
```
 
**Password:** `6C7h9GD8M6ai5nr7wo1RonrzFjj9yIrG`
 
---
 
## Level 5 → 6
 
This level was exactly the situation I predicted in the last one: finding a specific file in a much larger list. The file with the password is:
- human-readable
- 1033 bytes in size
- not executable
I started by looking at file permissions to see if anything stood out. It didn't; all the files had the same permissions.
 
Next I looked for human-readable files (ASCII text):
 
```bash
find . -type f -exec file {} \; | grep "ASCII"
```
 
This shortened the list, but it was still long, so I added the file size to make the search more specific:
 
```bash
find . -type f -size 1033c -exec file {} \; | grep "ASCII"
```
 
This gave me the file I was looking for.
 
**Key notes**
- `c` means bytes in `find`, so 1033 bytes is `-size 1033c`.
- `-size +1033c` returns files **larger** than 1033 bytes.
- `-size -1033c` returns files **smaller** than 1033 bytes.
- `! -executable` can be added to match the "not executable" condition.
**Password:** `pXa26xhMWaC2SvDotA4r9EgZkulOeSBW`
 
---
 
## Level 6 → 7
 
This level was daunting: the file could be anywhere on the server, buried among numerous directories and subdirectories holding hundreds, if not thousands, of files.
 
All I knew about the file:
- owned by user `bandit7`
- owned by group `bandit6`
- 33 bytes in size
I misread the instructions at first and wrote a command looking for a file owned by **either** user `bandit6` **or** user `bandit7`:
 
```bash
find / -type f -user bandit6 -o -type f -user bandit7
```
 
Luckily there was only one file on the server owned by `bandit7`, so I got the right file. But if more files matched either user, I'd have been stuck with another long list.
 
Then I realised a file is owned by both a user and a group, so I changed the command:
 
```bash
find / -type f -user bandit7 -a -group bandit6
```
 
This got me the correct answer. The main difference is the switch from OR to AND logic.
 
- `-o` is the OR operator.
- `-a` is the AND operator.
- With nothing between conditions, the default is AND.
I could make the search even more specific by adding the size, and hide the "Permission denied" noise by sending errors to `/dev/null`:
 
```bash
find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
```
 
**Password:** `Bmnnvf82KzQlfxgAI2d1zYbr1u9pr3E3`
 
---
 
## Level 7 → 8
 
The password is stored in `data.txt` next to the word "millionth".
 
This wasn't too hard: `grep` outputs the line containing the term you search for.
 
```bash
grep "millionth" data.txt
```
 
**Password:** `VR1ljMayciFxbnUokuQmJFw6QC9VKtub`
 
---
 
## Level 8 → 9
 
The password is stored in `data.txt` and is the only line of text that occurs only once.
 
Useful commands: `grep`, `sort`, `uniq`, `base64`, `tr`, `tar`, `gzip`, `bzip2`, `xxd`
 
I tried `uniq -u`, which prints only unique lines.
 
**Note:** `uniq` doesn't detect repeated lines unless they are adjacent. You need to sort the input first.
 
To sort a file alphabetically:
 
```bash
sort data.txt
```
 
So `uniq` has to be used with `sort`, piping the sorted output into `uniq`:
 
```bash
sort data.txt | uniq -u
```
 
`sort` orders the lines alphabetically, and `uniq -u` displays only lines that have no duplicates.
 
Other variations:
 
```bash
sort data.txt | uniq -c   # prints each line with the number of times it occurs
sort data.txt | uniq -d   # prints only lines that appear more than once
```
 
**Password:** `EjmOSvuAu7sGAHqHVcBDPirRe9T03kxl`
 
---
 
## Level 9 → 10
 
The password is in `data.txt` in one of the few human-readable strings, preceded by several `=` characters.
 
`data.txt` is a binary file, so it doesn't print properly to the terminal. The `strings` command extracts runs of printable characters, so other commands can use them without dealing with non-printable characters.
 
```bash
strings data.txt
```
 
This prints all the printable text in the file as a list.
 
The command that got me the answer:
 
```bash
strings data.txt | grep "==="
```
 
This returns all lines containing at least three `=` characters in a row.
 
**Password:** `B0s2khmbT9u0geKuOoVGW3JZKhndE3BG`
 
---
 
## Level 10 → 11
 
The password is stored in `data.txt`, which contains Base64-encoded data.
 
**What is Base64?**
Base64 is an encoding scheme that represents binary data using only printable ASCII characters. Decoding converts it back into its original form.
 
```bash
base64 -d data.txt
```
 
This decodes the Base64 data and prints the result as readable text.
 
**Password:** `pYfOY6HwUsDj5rL9UvyhU7MCmv8vN5Ro`
 
---
 
## Level 11 → 12
 
The password is stored in `data.txt`, where all lowercase (a–z) and uppercase (A–Z) letters have been rotated by 13 positions (ROT13).
 
"Rotated by 13 positions" means each letter moves 13 places along the alphabet, so `A` becomes `N` and `a` becomes `n`.
 
This really stumped me.
 
The answer is the `tr` (translate) command:
 
```bash
echo "text" | tr [your target] [what you want to change it to]
```
 
Examples:
 
```bash
echo "text" | tr 'a-z' 'A-Z'
# output: TEXT  (every lowercase letter becomes its uppercase counterpart)
 
echo "TEXT" | tr 'A-Z' 'a-z'
# output: text  (the opposite: uppercase to lowercase)
```
 
By passing the output of one command into the next, I can make the changes I need.
 
**How do I rotate characters?**
 
```bash
echo "b" | tr 'a-z' 'b-za'
# output: c   (shift by 1)
 
echo "B" | tr 'A-Z' 'C-ZA-B'
# output: D   (shift by 2)
 
echo "bB" | tr 'a-z' 'c-za-b' | tr 'A-Z' 'C-ZA-B'
# output: dD
```
 
The command that rotated by 13 and gave me the password:
 
```bash
cat data.txt | tr 'a-z' 'n-za-m' | tr 'A-Z' 'N-ZA-M'
```
 
It can also be done in one `tr`:
 
```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt
```
 
**Password:** `GROozWPO8QyN0mGrjUkID0WCYkZiQxrN`
 
---
 
## Level 12 → 13
 
The password is in `data.txt`, which is a hexdump of a file that has been repeatedly compressed. It's useful to work in a directory under `/tmp`: use `mktemp -d`, copy the file with `cp`, and rename it with `mv`.
 
**What is a hexdump?**
A human-readable display of computer data where each byte is shown as a two-digit hexadecimal (base 16) number.
 
**Notes**
- Decompressing a file that has been compressed multiple times is like peeling an onion.
- First reverse the hexdump back into binary with `xxd -r`.
- Then repeatedly check how the file is compressed using `file`, and use the matching tool: `gzip -d`, `bzip2 -d`, or `tar -xf`.
**Password:** `qQYQiHOBPR8zR61qxYqX45quvihF2uzk`
 
---
 
## Level 13 → 14
 
The password is stored in `/etc/bandit_pass/bandit14` and can only be read by `bandit14`. Instead of a password, you get a private SSH key to log into the next level.
 
**First attempt:**
 
```bash
ssh -i sshkey.private -p 2220 bandit14@localhost
```
 
Logging in via `localhost` from the server is no longer allowed. So I needed to run the command from my own machine, which meant securely transferring `sshkey.private` from the bandit13 server.
 
I exited back to my own machine and used `scp`:
 
```bash
scp -P 2220 bandit13@bandit.labs.overthewire.org:sshkey.private .
```
 
`scp` (secure copy) transfers files and directories between a local and remote system, or between two remote systems, using SSH for encryption and authentication. Note that `scp` uses a capital `-P` for the port.
 
Then I changed the key's permissions to `600`, because SSH refuses to use a private key that other users on the machine could read:
 
```bash
chmod 600 sshkey.private
```
 
A private key is effectively a password in a file, so if its permissions are too open, SSH treats it as compromised and ignores it. You'd see:
 
```
WARNING: UNPROTECTED PRIVATE KEY FILE!
Permissions 0644 for 'sshkey.private' are too open.
```
 
Finally, to access the server:
 
```bash
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
```
 
The `-i` flag lets you authenticate with the private key file instead of a password.
 
**Password:** `aaWecNkG4FhxJQxz07uiwzVP6bJiYS65`
 
---
 
## Level 14 → 15
 
The password can be retrieved by submitting the current level's password to port 30000 on localhost.
 
I need to connect to a service on the same machine (here, the remote server) and send it the password on a specific port.
 
`telnet` is a user interface to the TELNET protocol:
 
```bash
telnet [hostname_or_IP] [port]
```
 
This opens a connection to the given machine on the specified port:
 
```bash
telnet localhost 30000
```
 
Then paste the current password and press Enter.
 
> **To do:** revisit this level and do the helpful reading.
 
**Password:** `pbLYuZtTg4MgaqfJx8jbA9gKKGqM68A7`
 
---
 
## Level 15 → 16
 
The password can be retrieved by submitting the current password to port 30001 on localhost using SSL/TLS encryption.
 
It's the same premise as the last level (sending a message to a local service), but more secure: `telnet` sends everything in plain text, while this connection is encrypted with SSL/TLS (Secure Sockets Layer / Transport Layer Security).
 
For this we use `openssl`, whose `s_client` subcommand acts as a TLS client for connecting to encrypted services.
 
To connect, supply the hostname and port:
 
```bash
openssl s_client -crlf -connect localhost:30001 -servername localhost
```
 
**Key points**
- The hostname is supplied twice: `-connect` establishes the TCP connection, while `-servername` sets the hostname sent at the TLS level.
- From OpenSSL 1.1.1, `s_client` sets the server name automatically. You still need `-servername` if (1) you're on an older OpenSSL version, (2) you're connecting to an IP address, or (3) the TLS host needs to be different.
- Use `-noservername` to avoid sending hostname information in the TLS handshake.
- Include `-crlf`: it translates the newlines you type into a carriage return + line feed, for strict HTTP compliance.
**Password:** `kS0Hf0u5HiXFwKMKFqXvPdOTNGGa0X8V`
 
---
 
## Level 16 → 17
 
The credentials can be retrieved by submitting the current password to a port on localhost between 31000 and 32000. First find which ports have a server listening, then which of those speak SSL/TLS. Only one server gives the credentials; the others just echo back what you send.
 
To find listening ports and identify which speak SSL/TLS, I used `nmap` (a network exploration tool and port scanner):
 
```bash
nmap -sV -T4 -p 31000-32000 localhost
```
 
- `-T4` speeds up the scan.
- `-p` specifies the port range.
- `-sV` identifies the service and its version.
This produced a list of ports in the range with their state, service, and version. One of them, **port 31790**, was the one returning data, and it used SSL, so I needed `openssl s_client` to connect and send the current password.
 
The current password can be found with:
 
```bash
cat /etc/bandit_pass/bandit16
```
 
My first connection attempt:
 
```bash
openssl s_client -crlf -connect localhost:31790 -servername localhost
```
 
This connected, but put me in an interactive mode where single letters (`k`/`K`, `R`, `Q`) are treated as commands.
 
**Fix:** add `-quiet` (or `-ign_eof`), which turns off the single-letter commands so everything you type goes to the server:
 
```bash
openssl s_client -crlf -connect localhost:31790 -quiet
```
 
This didn't return a password, but an RSA private key that can be used with SSH to access the next level. I don't have write permission in the current directory, so I copied the key (from the `BEGIN` line to the `END` line), left the server, and saved it on my own machine (see Level 13 → 14):
 
```bash
touch private.key
vim private.key      # paste the key in
chmod 600 private.key
```
 
Then made the SSH connection:
 
```bash
ssh -i private.key bandit17@bandit.labs.overthewire.org -p 2220
```
 
And got the password:
 
```bash
cat /etc/bandit_pass/bandit17
```
 
**Password:** `pWXMAZoxGC8JmDMfmT5MGEsobMM3vnj2`
 
---
 
## Level 17 → 18
 
There are two files in the home directory: `passwords.old` and `passwords.new`. The password is in `passwords.new` and is the only line that changed between the two.
 
`diff` lists the differences between files:
 
```bash
diff passwords.old passwords.new
```
 
The line marked with `>` is the one from `passwords.new`.
 
**Password:** `OQxXZjELndr90zuhOTDYBEomI0SZITXI`
 
---
 
## Level 18 → 19
 
The password is in a file called `readme` in the home directory, but someone modified `.bashrc` to log you out as soon as you log in with SSH.
 
So we can't log in with the default shell (`bash`) as normal. You can see the shells available on the system with:
 
```bash
cat /etc/shells
```
 
SSH lets you give a command to run instead of the normal login shell. The `-t` flag forces a terminal to be allocated, so running `/bin/sh` gives an interactive shell that never reads `.bashrc`:
 
```bash
ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "/bin/sh"
```
 
Then read the file:
 
```bash
cat readme
```
 
**Password:** `KpsOfPkcP7i1FlIExk2QEjyt6dw8dxZI`
 
---
 
## Level 19 → 20
 
To access the next level, use the setuid binary in the home directory. Run it without arguments to see how to use it. The password is in the usual place (`/etc/bandit_pass`) once you've used the binary.
 
> **To do:** write up notes for this level.
 
**Password:** `4pIjcunZ0fK2vmp3IwfG8Vf7VhxD6pOA`
 
