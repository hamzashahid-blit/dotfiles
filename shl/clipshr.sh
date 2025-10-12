#!/usr/bin/env bash

if xclip -t TARGETS -o | grep image/png &>/dev/null; then
    clipmime=image/png
	echo $clipmime
	xclip -sel clip -t $clipmime -o >> /tmp/xclip
	link=$(curl --upload-file /tmp/xclip https://transfer.sh/clipshr)
	echo $link
	echo $link | qrencode -s8 -o /tmp/clipshr.png
	sxiv /tmp/clipshr.png
else
    clipmime=text/plain
    xclip -sel clip -t $clipmime -o | qrencode -s 8 -o /tmp/clipshrqr.png
	sxiv /tmp/clipshrqr.png
fi

# xclip -selection clipboard -t $clipmime -o | qrencode -s 8 -o /tmp/clipshrqr.png && sxiv /tmp/clipshrqr.png

# echo $clipmime
# xclip -t $clipmime -o >> /tmp/xclip
# link=$(curl --upload-file /tmp/xclip https://transfer.sh/clipshr)
# echo $link
# echo $link | qrencode -s8 -o /tmp/clipshr.png
# sxiv /tmp/clipshr.png
