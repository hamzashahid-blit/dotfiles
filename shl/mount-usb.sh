#!/bin/env bash

raw_partitions=$(lsblk -rno "name,size")
partitions=""
while read name size; do
	 partitions+="\n$name ($size)"
done <<< "$raw_partitions" # quotes generally important

partitions=$(echo -e "$partitions" | sed '1d')

part_name=$(echo -e "CANCEL\n$partitions" | tofi --prompt-text "Which partition to mount?" | cut -f1 -d' ')
[ "$part_name" = "CANCEL" ] && exit

part_size=$(echo -e "$raw_partitions" | grep "$part_name " | cut -f2 -d' ')
part_info=$(lsblk -rno "name,label" | grep "$part_name ") # SPACE IS IMP

if [ $(echo "$part_info" | wc -w) -lt 2 ]; then
	# Partition has no Label
	mount_folder_name=$(echo "$part_name" | tr -d '[:space:]')
else
	part_label=$(echo "$part_info" | cut -d' ' -f2)
	mount_folder_name="$part_name-$part_label"
fi

mount_location=$(echo -e "CANCEL\n/mnt\n/media/$mount_folder_name" | tofi --prompt-text "Where to mount?")
[ "$mount_location" = "CANCEL" ] && exit

# Actually mount
mount_error=$(sudo mount "/dev/$part_name" "$mount_location" 2>&1 | cut -f1 -d' ' --complement)

if [ $? -eq 0 ]; then
	# MOUNT SUCCESSFUL
	notification_reply=$(dunstify -A "yes, yeah" "Device Mount" "Partition $part_name ($part_size) with label '$part_label' has been mounted to '$mount_location'. Right-click to open.")
	if [ "$notification_reply" = "yes" ]; then
		gui_or_tui=$(echo -e "GUI\nTUI" | tofi)
		case $gui_or_tui in
			"TUI" )
				alacritty --working-directory=$mount_location
				;;
			"GUI" )
				pcmanfm $mount_location
				;;
		esac
	fi
else
	# MOUNT UNSUCCESSFUL
	[ -z "$part_size" ] && part_size="???"
	[ -z "$part_label" ] && part_label="???"
	dunstify -u critical "[ERROR] Device Mount" "Partition $part_name ($part_size) with label '$part_label' was UNABLE to mount to '$mount_location' due to:\n'$mount_error'"
fi
