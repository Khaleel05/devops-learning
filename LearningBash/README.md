# ⚔️ Bash Battle Arena
 
A command-line game for learning Bash scripting. Each level is a mission you complete by writing a Bash script. Every 5th level is a **Boss Battle** that combines everything from the previous levels.
 
My solutions for every level are in this repo. If you're playing along, try each level yourself first, then use the commands and tips below if you get stuck.
 
---
 
## 🚀 Getting Started
 
```bash
# Make a script executable
chmod +x script.sh
 
# Run it
./script.sh
 
# Run it with debug output (shows each command as it runs)
bash -x script.sh
```
 
**General tips**
- Start every script with `#!/bin/bash`.
- Always quote variables: `"$file"`, not `$file`. This saves you from bugs when filenames have spaces.
- Use `man <command>` or `<command> --help` to read about any command.
- Paste your scripts into [ShellCheck](https://www.shellcheck.net/) to catch common mistakes.
---
 
## Level 1: The Basics
 
**Mission:** Create a directory named `Arena` and then inside it, create three files: `warrior.txt`, `mage.txt`, and `archer.txt`. List the contents of the `Arena` directory.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `mkdir` | Creates a directory |
| `cd` | Changes directory |
| `touch` | Creates an empty file |
| `ls` | Lists directory contents |
 
**Tips**
- `touch` can create several files in one go: `touch a.txt b.txt c.txt`.
- `mkdir -p` won't throw an error if the directory already exists, handy when you run your script more than once.
- You can create files inside a directory without `cd`-ing into it: `touch Arena/warrior.txt`.
---
 
## Level 2: Variables and Loops
 
**Mission:** Create a script that outputs the numbers 1 to 10, one number per line.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `for ... in ...; do ... done` | Loops over a list of values |
| `{1..10}` | Brace expansion, generates a sequence |
| `seq 1 10` | Prints a sequence of numbers |
| `echo` | Prints text |
 
**Tips**
- Reference a variable with `$`: `echo $i`.
- Brace expansion doesn't work with variables (`{1..$n}` fails). Use `seq 1 "$n"` or a C-style loop: `for ((i=1; i<=n; i++))`.
---
 
## Level 3: Conditional Statements
 
**Mission:** Write a script that checks if a file named `hero.txt` exists in the `Arena` directory. If it does, print `Hero found!`; otherwise, print `Hero missing!`.
 
**Helpful commands**
| Test | Meaning |
|---|---|
| `[ -f file ]` | True if file exists and is a regular file |
| `[ -d dir ]` | True if directory exists |
| `[ -e path ]` | True if anything exists at that path |
| `[ ! ... ]` | Negates a test |
 
**Tips**
- Spaces inside the brackets are required: `[ -f "$file" ]`, not `[-f "$file"]`.
- Structure: `if ...; then ... else ... fi`.
- Test it both ways: run once without `hero.txt`, then `touch Arena/hero.txt` and run again.
---
 
## Level 4: File Manipulation
 
**Mission:** Create a script that copies all `.txt` files from the `Arena` directory to a new directory called `Backup`.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `cp` | Copies files |
| `mkdir -p` | Creates a directory only if it doesn't exist |
| `*.txt` | Wildcard matching all `.txt` files |
 
**Tips**
- Make sure the destination exists before copying into it.
- A trailing slash on the destination (`Backup/`) makes it clear you mean a directory.
- `cp -v` shows each file as it's copied, useful for checking your work.
---
 
## Level 5: 🐉 Boss Battle 1 - Combining Basics
 
**Mission:** Write a script that:
1. Creates a directory named `Battlefield`.
2. Inside `Battlefield`, creates files named `knight.txt`, `sorcerer.txt`, and `rogue.txt`.
3. Checks if `knight.txt` exists; if it does, moves it to a new directory called `Archive`.
4. Lists the contents of both `Battlefield` and `Archive`.
**Helpful commands**
`mkdir`, `touch`, `if [ -f ... ]`, `mv`, `ls`
 
**Tips**
- Create `Archive` before you try to move anything into it.
- `echo` a label before each `ls` so the output is easy to read.
- Re-running the script? `mkdir` will complain if `Battlefield` exists. Use `mkdir -p` or clean up with `rm -r` between runs.
---
 
## Level 6: Argument Parsing
 
**Mission:** Write a script that accepts a filename as an argument and prints the number of lines in that file. If no filename is provided, display a message saying `No file provided`.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `$1`, `$2`, ... | Positional arguments passed to the script |
| `$#` | Number of arguments passed |
| `[ -z "$1" ]` | True if the string is empty |
| `wc -l` | Counts lines |
| `exit 1` | Exits with an error status |
 
**Tips**
- `wc -l file.txt` prints the count *and* the filename. `wc -l < file.txt` prints just the number.
- Store a command's output in a variable with `$(...)`: `count=$(wc -l < "$1")`.
- Bonus: also check the file actually exists before counting.
- Usage: `./level6.sh test.txt`
---
 
## Level 7: File Sorting Script
 
**Mission:** Write a script that sorts all `.txt` files in a directory by their size, from smallest to largest, and displays the sorted list.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `ls -lS` | Lists files sorted by size (largest first) |
| `ls -lSr` | Same, but reversed (smallest first) |
| `find -type f -name "*.txt"` | Finds files by name |
| `sort -k 5,5 -h` | Sorts by column 5, understanding sizes like `4.0K` |
| `awk '{print $5, $9}'` | Prints specific columns |
| `du -b` / `stat` | Gets exact file sizes |
 
**Tips**
- The simplest route is `ls -lSr`, but piping through `sort` teaches you more.
- Empty files all have size 0, so add some content (`echo "text" > file.txt`) to see the sorting actually work.
---
 
## Level 8: Multi-File Searcher
 
**Mission:** Create a script that searches for a specific word or phrase across all `.log` files in a directory and outputs the names of the files that contain the word or phrase.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `grep` | Searches for text in files |
| `grep -l` | Prints only the names of matching files |
| `grep -i` | Case-insensitive search |
| `grep -r` | Searches recursively through subdirectories |
| `grep -w` | Matches whole words only |
 
**Tips**
- Quote your search term so phrases with spaces work: `grep -l "$term"`.
- Make it reusable by taking the search term as an argument (`$1`) instead of hardcoding it.
- Create some test `.log` files first, with and without the word.
---
 
## Level 9: Script to Monitor Directory Changes
 
**Mission:** Write a script that monitors a directory for any changes (file creation, modification, or deletion) and logs the changes with a timestamp.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `fswatch -r dir` | Watches a directory for changes (**macOS**, install with `brew install fswatch`) |
| `inotifywait -m -r dir` | Watches a directory for changes (**Linux**, install `inotify-tools`) |
| `date +'%Y-%m-%d %H:%M:%S'` | Prints a formatted timestamp |
| `while read line; do ... done` | Processes output line by line |
| `>>` | Appends to a file |
 
**Tips**
- Pipe the watcher into a `while read` loop to handle each event as it happens.
- `inotifywait -e create,modify,delete` lets you see exactly which kind of event happened.
- With `fswatch`, check whether the path still exists (`[ -e "$path" ]`) to tell a deletion apart from a create/modify.
- The script runs forever. Stop it with `Ctrl+C`, and test it by changing files from a second terminal.
- Use `>>` (append), not `>` (overwrite), for the log file.
---
 
## Level 10: 🐉 Boss Battle 2 - Intermediate Scripting
 
**Mission:** Write a script that:
1. Creates a directory called `Arena_Boss`.
2. Creates 5 text files inside the directory, named `file1.txt` to `file5.txt`.
3. Generates a random number of lines (between 10 and 20) in each file.
4. Sorts these files by their size and displays the list.
5. Checks if any of the files contain the word `Victory`, and if found, moves the file to a directory called `Victory_Archive`.
**Helpful commands**
| Command | What it does |
|---|---|
| `$RANDOM` | Random number between 0 and 32767 |
| `$((RANDOM % 11 + 10))` | Random number between 10 and 20 |
| `seq 1 $n` | Sequence up to a variable |
| `grep -q` | Quiet search, just returns true/false |
| `mv` | Moves files |
 
**Tips**
- `RANDOM % 11` gives 0–10, so adding 10 gives 10–20.
- Nested loops work well: the outer loop makes each file, the inner loop writes the lines.
- `grep -q` is perfect inside an `if` because you only care whether the word is there.
- To check step 5 works, randomly insert `Victory` into some files, or add it to one by hand.
---
 
## Level 11: Automated Disk Space Report
 
**Mission:** Create a script that checks the disk space usage of a specified directory and sends an alert if the usage exceeds a given threshold.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `du -sh dir` | Size of a directory, human-readable |
| `du -sm dir` | Size in megabytes (a plain number, good for comparing) |
| `df -h` | Disk usage of whole filesystems |
| `df --output=pcent dir` | Percentage used of the disk a directory is on (Linux) |
| `[ "$a" -gt "$b" ]` | Integer "greater than" comparison |
 
**Tips**
- `-gt`, `-lt`, `-eq` only work on whole numbers, so don't compare values like `4.0K`. Use `du -sm` or `du -sk` to get a plain number.
- Use `awk '{print $1}'` to grab just the number from `du`'s output.
- Be clear about units: `du` measures the directory's size (MB), while `df` gives a percentage of the whole disk. Make your alert message match the unit you measured.
- Make the threshold a variable (or an argument) so it's easy to change.
---
 
## Level 12: Simple Configuration File Parser
 
**Mission:** Write a script that reads a configuration file in the format `KEY=VALUE` and prints each key-value pair.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `while IFS='=' read -r key value` | Reads a line and splits it on `=` |
| `done < file` | Feeds a file into a loop |
| `cut -d= -f1` | Alternative way to split on a delimiter |
 
**Tips**
- Create a test `settings.conf` first, e.g.:
```
  USERNAME=player1
  LEVEL=12
  THEME=dark
```
- `read -r` stops backslashes being treated as escape characters.
- Bonus: skip blank lines and comments with `[[ -z "$key" || "$key" == \#* ]] && continue`.
- If the last line of the file has no newline, it may be skipped. `|| [ -n "$key" ]` after `read` fixes that.
---
 
## Level 13: Backup Script with Rotation
 
**Mission:** Create a script that backs up a directory to a specified location and keeps only the last 5 backups.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `tar -czf name.tar.gz dir` | Creates a compressed archive |
| `tar -tzf name.tar.gz` | Lists what's inside an archive (to check it) |
| `date +"%Y-%m-%d_%H-%M-%S"` | Timestamp for unique backup names |
| `ls -t` | Lists files newest first |
| `tail -n +6` / `sed '1,5d'` | Skips the first 5 lines |
| `rm -f` | Deletes files |
 
**Tips**
- A timestamp in the filename keeps each backup unique and easy to sort.
- Rotation logic: list backups newest first, skip the first 5, delete the rest.
- `cd "$BACKUP_DIR" || exit` stops the script if the `cd` fails, so you don't delete files in the wrong place.
- Test rotation by running the script 7–8 times, then check only 5 backups remain. (Timestamps include seconds, so wait a second between runs.)
---
 
## Level 14: User-Friendly Menu Script
 
**Mission:** Create an interactive script that presents a menu with options for different system tasks (e.g. check disk space, show system uptime, list users), and executes the chosen task.
 
**Helpful commands**
| Command | What it does |
|---|---|
| `read -rp "Prompt: " var` | Prompts the user and stores the input |
| `case ... in ... esac` | Matches input against options |
| `df -h` | Disk space |
| `uptime` | System uptime |
| `cut -d: -f1 /etc/passwd` | Lists user accounts |
| `who` | Shows logged-in users |
| `select` | Bash's built-in menu builder |
 
**Tips**
- Always include a `*)` catch-all in your `case` for invalid input.
- Each case branch ends with `;;`.
- Bonus: wrap the menu in a `while true` loop with a "Quit" option so users can run several tasks.
- Try `select` for a different way to build menus: `select opt in "Disk" "Uptime" "Quit"; do ... done`.
---
 
## Level 15: 🐉 Boss Battle 3 - Advanced Scripting
 
**Mission:** Write a script that:
1. Presents a menu to the user with the following options:
   - Check disk space
   - Show system uptime
   - Backup the `Arena` directory and keep the last 3 backups
   - Parse a configuration file `settings.conf` and display the values
2. Executes the chosen task.
**Helpful commands**
Everything from Levels 11–14: `read`, `case`, `df`, `uptime`, `tar`, `ls -t`, `while IFS='=' read`.
 
**Tips**
- Note the change from Level 13: this backup keeps **3**, not 5. Update the number of lines you skip.
- Put each task in its own function (`backup_arena() { ... }`) and call it from the `case`. It keeps the menu readable.
- Be careful with `cd` inside a branch: it changes the directory for the rest of the script. Run it in a subshell `( cd dir && ... )` or use full paths instead.
- Make sure `settings.conf` and the `Arena` directory exist before testing those options.
---
 
## 🏆 Bash Master
 
Completed all 15 levels? You're a Bash Master. Some ways to keep going:
- Revisit earlier levels and make them accept arguments instead of hardcoded values.
- Add error handling with `set -euo pipefail` at the top of your scripts.
- Run every solution through ShellCheck and fix the warnings.