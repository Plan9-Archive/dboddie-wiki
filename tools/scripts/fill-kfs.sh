# To be run by the shell in the hosted Inferno environment.

mount -c {disk/kfs -r /fsdisk/fs.part} /n/kfs

time fcp -r /acme /n/kfs/acme
time fcp -r /appl /n/kfs/appl
time fcp -r /dis /n/kfs/dis
time fcp -r /doc /n/kfs/doc
time fcp -r /fonts /n/kfs/fonts
time fcp -r /icons /n/kfs/icons
#time fcp -r /include /n/kfs/include
time fcp inferno-os* /n/kfs/
time fcp -r /keydb /n/kfs/keydb
time fcp -r /lib /n/kfs/lib
time fcp -r /locale /n/kfs/locale
time fcp -r /mail /n/kfs/mail
time fcp -r /man /n/kfs/man
#time fcp -r /mkfiles /n/kfs/mkfiles
time fcp -r /module /n/kfs/module

mkdir /n/kfs/n
mkdir /n/kfs/n/cd
mkdir /n/kfs/n/client
mkdir /n/kfs/n/disk
mkdir /n/kfs/n/dist
mkdir /n/kfs/n/dos
mkdir /n/kfs/n/dump
mkdir /n/kfs/n/ftp
mkdir /n/kfs/n/gridfs
mkdir /n/kfs/n/kfs
mkdir /n/kfs/n/local
mkdir /n/kfs/n/rdbg
mkdir /n/kfs/n/registry
mkdir /n/kfs/n/remote
time fcp -r /services /n/kfs/services
mkdir /n/kfs/tmp
time fcp -r /usr /n/kfs/usr
#time fcp -r /usr/inferno/lib /tmp/usr/fs/$USER/

unmount /n/kfs
echo 'fs written.'
