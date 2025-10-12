#!/bin/env bash

script="/home/hamza/shl/random-word-generator.sh"
input=$(dunstify -u 0 -A "yes,yeah" "Random Word Generator" "Do you want to generate a random word?")
echo "INPUT = $input"

myreply () {
	echo "REPLY"
	word=$(sh $script)
	dunstify "Random Word Generator" "Your random word is: $word"
}
mydismissed () {
	echo "DISMISSED"
}
mytimeout () {
	echo "TIMEOUT"
}

case $input in
    "yes" )
        myreply
        ;;
    "2" )
		mydismissed
		;;
    "1" )
		mytimeout
		;;
esac

