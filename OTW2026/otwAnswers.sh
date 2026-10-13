#!/usr/bin/expect
spawn ssh bandit0@bandit.labs.overthewire.org -p 2220
expect "password"
send -- "bandit0\r"

