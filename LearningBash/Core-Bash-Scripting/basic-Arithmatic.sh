#!/bin/bash

#Create a script that takes two numbers as input and performs basic arithmetic operations 
#(addition, subtraction, multiplication, division).

NUM1=$1
NUM2=$2

echo "$NUM1 + $NUM2 = $(($NUM1 + $NUM2))"
echo "$NUM1 - $NUM2 = $(($NUM1 - $NUM2))"
echo "$NUM1 * $NUM2 = $(($NUM1 * $NUM2))"
if [ $NUM2 -eq 0 ];then 
    echo "undefined"
    exit 1
else
    echo "$NUM1/$NUM2 = $(($NUM1 / $NUM2))"
fi