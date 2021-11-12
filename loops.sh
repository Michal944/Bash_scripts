#!/bin/bash


echo "while"
A=0
while [[ $A -lt 10 ]]
do
    echo "A: $A"
    ((A++))
done


echo "until"
B=0
until [[ $B -gt 10 ]] 
do
    echo "B: $B"
    ((B++))
done

#for exampl 1

C="1 2 3 4 5 6 7"
for X in $C
do
    echo "C: $X"
done

echo " (( C=0; C<10))"
for (( C=0; C<10; C++))
do
    echo "C: $C"

done


