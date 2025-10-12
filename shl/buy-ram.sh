#!/bin/env bash

#######################################
# Don't just blindly run this script! #
#######################################

sync; echo 3 > /proc/sys/vm/drop_caches 
swapoff -a
swapon -a
