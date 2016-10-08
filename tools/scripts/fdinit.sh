load std

echo 1 > /dev/jit

bind -a '#f' /dev
dossrv -f /dev/fd0disk

echo 'Adding the master boot record...'
disk/mbr -m /n/dos/mbr /dev/sdC0/data
echo 'Partitioning the first hard disk...' 
#disk/fdisk /dev/sdC0/data
disk/fdisk -a -b -w /dev/sdC0/data
echo 'Creating the 9fat and fs subpartitions...'
disk/prep -bw -a^(9fat fs) /dev/sdC0/plan9
echo 'Formatting the 9fat subpartition...'
disk/format -b /n/dos/pbslba -d -r 2 /dev/sdC0/9fat

unmount /n/dos

echo 'Mounting the 9fat subpartition...'
dossrv -f /dev/sdC0/9fat
echo 'Copying files to the 9fat subpartition...'
echo 'bootfile=sdC0!9fat!ipc.gz' > /n/dos/plan9.ini
unmount /n/dos

echo 'Creating the fs subpartition...'
mount -c {disk/kfs -r /dev/sdC0/fs} /n/kfs
unmount /n/kfs

#sh -n
echo 'Now shut down (close the qemu window) and continue the installation.'
