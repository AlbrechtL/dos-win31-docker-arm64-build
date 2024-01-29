#!/usr/bin/env bash

# Based on https://github.com/qemus/qemu-docker
set -Eeuo pipefail


APP="OpenWrt"
SUPPORT="https://github.com/AlbrechtL/dos_win31-docker-arm64-build"

cd /run

# Initialize system
. reset.sh      

trap - ERR

# Check if rootfs is in volume
FILE=/storage/msdos.disk
if [ -f "$FILE" ]; then
    info "$FILE exists. Nothing to do."
else 
    info "$FILE does not exist. Copying image to storage ..."
    cp /var/vm/msdos.disk $FILE
fi


info "Activating web VNC ..."
[ ! -f "$INFO" ] && error "File $INFO not found?!"
rm -f "$INFO"
[ ! -f "$PAGE" ] && error "File $PAGE not found?!"
rm -f "$PAGE"


info "Booting image using $VERS..."

[[ "$DEBUG" == [Yy1]* ]] && set -x
exec qemu-system-i386 \
-m 64 \
-display vnc=:0,websocket=5700 \
-vga std \
-hda /storage/msdos.disk
 