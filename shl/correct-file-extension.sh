#!/bin/bash

wall_dir="/home/hamza/pix/walls"
wall_pic="$wall_dir/rockman.jpg"

new_ext=$(file '$wall_pic' | cut -d' ' -f2 | tr '[:upper:]' '[:lower:]')
echo $new_ext
