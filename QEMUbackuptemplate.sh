#!/bin/bash

# Include appropriate paths (since cron doesn't use the normal environment)
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin

# The date of the last backup
#lastbackup=(date '+%Y-%m-%d' --date='7 days ago')

# The VM we're backing up
vm=vmname
domain=vmname #usually the same as the "vm" variable, but remember case sensitive. 

# The date of the backup
backupdate=`date +%Y-%m-%d`

# Freeze guest filesystems. Make sure you have the QEMU guest agent installed and running inside the vm's in order to handle snapshots without risking data corruption.
virsh domfsfreeze ${domain}

# Create snapshot. Perhaps it would be better practice to move the snapshot location to another directory, but for now.
qemu-img create -f qcow2 -b /var/lib/libvirt/images/${vm}.qcow2 
/var/lib/libvirt/images/${vm}snapshot.qcow2

# Thaw guest filesystems
virsh domfsthaw ${domain}

# Take backup from snapshot. Make sure /backup exists or you change to another location.
qemu-img convert -O raw /var/lib/libvirt/images/${vm}snapshot.qcow2 
/backup/${vm}-${backupdate}.img

# Rsync this to an offsite backup share. Change these fields to suite your environment. Of course you can always backup via some other method.
rsync /backup/${vm}-${backupdate}.img rsync://user@rsyncserver:/mybackups/

# Cleanup snapshot and local backup copy. This section here is another reason why I may move the snapshot location. rm -f inside the vm images directory makes me nervous after looking at this now.
rm -f /var/lib/libvirt/images/${vm}snapshot.qcow2
rm -f /backup/${vm}-${backupdate}.img

