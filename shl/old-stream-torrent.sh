#!/usr/bin/env bash

domains=("https://1337x.to"
		 "https://1337x.tw" "https://1337x.is"
		 "https://x1337x.ws"
		 "https://x1337x.eu"
		 "https://x1337x.se"
		 "https://1337x.st"
		 "https://1337x.unblocked.ic"
		 "https://1337x.gd")
cachedir="$HOME/.cache/stream-torrent"
mkdir $cachedir

## Domain Finding
for d in "${domains[@]}"
do
	echo "Testing domain: $d..."
	[ -n "$(wget -qO- "$d")" ] && domain=$d && break
done

[ -n $domain ] \
	&& echo "Working domain found: $domain" \
	|| echo "No working domain found :( , Exiting..." || exit

## Search Torrent
echo "Searching for \"$1\"...";

page="$(wget -qO- "$domain/search/$1/1/")"
mainCol="$(echo "$page" | grep -i "class=\"coll-1")"

# Get search results -> HTML entries -> refine
links=($(echo "$mainCol" | awk -v OFS="\n" -v domain="$domain" 'match($0, /<\/a><a href="([^"]*)/, a) {print domain a[1]}'))
namesArray=($(echo "$mainCol" | awk -v OFS="\n" 'match($0, /<a href=".*">(.*)<\/a>/, a) {print a[1]}'))

names="$(echo "${namesArray[@]}" | awk -v OFS="\n" '{print $0}')"

# echo "$mainCol"
# echo ${links[2]}

# Choose torrent
# echo "${names[@]}" | fzf --cycle +m --preview="echo {}"
echo "$names"

# echo ${links[@]} | tr -s ' ' '\n'
