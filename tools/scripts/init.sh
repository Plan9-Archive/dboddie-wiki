load std

echo 1 > /dev/jit
x=`{ls /dev/sd*/fs}

echo 'Mounting kfs file systems...'
cmd='{disk/kfs -n main '^$x^'}'
mount -c $cmd /n/kfs

echo 'Requesting an IP address...'
x=`{cat /net/ipifc/clone}
echo bind ether /net/ether0 > /net/ipifc/$x/ctl
ip/dhcp /net/ipifc/$x

echo 'Starting the DNS service...'
ndb/cs
ndb/dns

echo 'Binding directories...'
bind -b -c /n/kfs/acme /acme
bind -b -c /n/kfs/appl /appl
bind -b -c /n/kfs/dis /dis
bind -b -c /n/kfs/doc /doc
bind -b -c /n/kfs/fonts /fonts
bind -b -c /n/kfs/icons /icons
#bind -b -c /n/kfs/include /include
bind -b -c /n/kfs/keydb /keydb
bind -b -c /n/kfs/lib /lib
bind -b -c /n/kfs/locale /locale
bind -b -c /n/kfs/mail /mail
bind -b -c /n/kfs/man /man
#bind -b -c /n/kfs/mkfiles /mkfiles
bind -b -c /n/kfs/module /module
#bind -b -c /n/kfs/src /src
#bind -b -c /n/kfs/sys /sys
bind -b -c /n/kfs/tmp /tmp
bind -b -c /n/kfs/usr /usr
#bind -b -c /n/kfs/wrap /wrap

sh -n
