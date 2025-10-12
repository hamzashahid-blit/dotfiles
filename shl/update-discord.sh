#!/usr/bin/env bash

cd ~/src/void-packages
git pull
./xbps-src binary-bootstrap
echo XBPS_ALLOW_RESTRICTED=yes > etc/conf
./xbps-src pkg discord
cd masterdir
xi discord
