#!/bin/bash

function usage()
{
	echo "Usage: $0 [chroot-dir] "
	exit 1
}

[ "$#" == "1" ] || usage 
[ -d $1 ] || usage 

chdir="${1}/"

cp /etc/resolv.conf $chdir/etc


# Mounting the necessary filesystems

# In a few moments, the Linux root will be changed towards the new
# location. To make sure that the new environment works properly,
# certain filesystems need to be made available there as well.

# The filesystems that need to be made available are:

# /proc/ which is a pseudo-filesystem (it looks like regular files, but
# is actually generated on-the-fly) from which the Linux kernel exposes
# information to the environment

# /sys/ which is a pseudo-filesystem, like /proc/ which it was once
# meant to replace, and is more structured than /proc/

# /dev/ is a regular file system, partially managed by the Linux device
# manager (usually udev), which contains all device files

# The /proc/ location will be mounted on /mnt/gentoo/proc/ whereas the
# other two are bind-mounted. The latter means that, for instance,
# /mnt/gentoo/sys/ will actually be /sys/ (it is just a second entry
# point to the same filesystem) whereas /mnt/gentoo/proc/ is a new mount
# (instance so to speak) of the filesystem.

# root #mount -t proc proc /mnt/gentoo/proc
# root #mount --rbind /sys /mnt/gentoo/sys
# root #mount --make-rslave /mnt/gentoo/sys
# root #mount --rbind /dev /mnt/gentoo/dev
# root #mount --make-rslave /mnt/gentoo/dev

# The --make-rslave operations are needed for systemd support later in
# the installation.

# When using non-Gentoo installation media, this might not be
# sufficient. Some distributions make /dev/shm a symbolic link to
# /run/shm/ which, after the chroot, becomes invalid. Making /dev/shm/ a
# proper tmpfs mount up front can fix this:

# root #rm /dev/shm && mkdir /dev/shm
# root #mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm

# Also ensure that mode 1777 is set
# root # chmod 1777 /dev/shm

mount -t proc none  $chdir/proc

# mount --rbind /dev  $chdir/dev
mount -o bind /dev  $chdir/dev
mount -o bind /dev/pts $chdir/dev/pts

# mount --rbind /sys $chdir/sys
mount -o bind /sys $chdir/sys

mount -o bind /tmp $chdir/tmp

X11_COOKIE=$( xauth list $DISPLAY | cut -f 1 -d\      )
xauth extract $chdir/.Xauthority $X11_COOKIE
chmod 777 $chdir/.Xauthority 
export XAUTHORITY=/.Xauthority

/bin/chroot $chdir /bin/bash

umount -l $chdir/tmp
umount -l $chdir/sys
umount -l $chdir/dev/pts
umount -l $chdir/dev
umount -l $chdir/proc


