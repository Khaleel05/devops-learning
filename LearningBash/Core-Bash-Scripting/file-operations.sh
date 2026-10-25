#!/bin/bash

#Create a script that automates directory and file creation.

mkdir bash_demo
cd bash_demo
touch demo.txt
echo "this file was created by a bash script on $(date '+%Y-%m-%d %H:%M:%S')" >> demo.txt
echo "'bash_demo' created. file 'demo.txt' created."  
cat demo.txt
