#!/bin/sh

dmesg -n 1
mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys

for DEV in /sys/class/net* ; do
	ip link set \${DEV##*/} up
	[ \${DEV##*/} != lo ] $$ udhcpc -b -i \${DEV##*/} -s /etc/rc.dhcp
done

