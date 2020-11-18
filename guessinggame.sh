#!/bin/bash

count=$(ls -1 | wc -l)
echo "Welcome to the Coursera bash GuessingGame"

function guess {
   read -p "Enter a integer: " var1
}
guess

if [[ $var1 == [A-Za-z]  ]]; then
        echo "Only integers allowed!!!..Try Again"
        exit 0
fi

        while [[ ($var1 -lt $count) || ($var1 -gt $count) || ($var1 -eq $count) || ( -z $var1 ) ]]; do
                if [ -z $var1 ]; then
                echo "Please enter some number"
                guess
                elif [ $var1 -eq $count ]; then
                echo "Well Done the value $var1 is correct"
                exit 0
                elif [ $var1 -lt $count ]; then
                echo "The number is incorrect try with a higher value"
                guess
                else
                echo "The number is incorrect try with a lower value"
                guess
                fi
        done