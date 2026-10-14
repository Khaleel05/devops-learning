#!/bin/bash

# basic concepts

#variables

name="Ahmed"
echo "Hello, $name"

#comments are created using the # at the beginning of your line.

#Conditionals:
#making dicisions with if statements

name="Alice"

echo "$name"
if [ "$name" = "Alice" ]; then 
	echo "Hi Alice!"
fi  

#loops
#repeat actions with for or while loops


#For loops
for i in 1 2 3 4; do 
	echo "Number $i"
done

#While loops

i=1
while [ $i -le 10 ]; do
	echo $i
	((i++))
done
echo "out of loop"

#funcitons
#Groups of commands to reuse 

greet() { echo "hello, world!"  
} 

greet


#user input 
read -p "enter your name: " username 
echo -e "\nhello, $username!" 

