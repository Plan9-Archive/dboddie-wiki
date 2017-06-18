# Building a PC Disk Image

## Overview

The *tools* directory contains a set of bash scripts for automating the process
of creating a hosted environment, a kernel for the PC, and images for floppy
and hard disks. In this document we will create a hard disk image. This is a
five stage process:

1. Create a hosted environment containing the files to include in the disk image.
2. Create an empty hard disk image.
3. Build a kernel to run from floppy disk which will be used to format the hard
  disk image - we will run this in *qemu*.
4. Build a kernel to run from the hard disk and install it in the FAT
  subpartition.
5. Copy the files from the hosted environment into the kfs subpartition.

We use the *make-install-root.sh* and *make-disk.sh* scripts to do this, as
described below.

## Running the scripts

Assuming you are starting from scratch, create a new directory and go into it.

Fetch the Inferno distribution into the *inferno-os* directory and the contents
of this Wiki into the *inferno-wiki* directory:

```
#!bash

hg clone https://bitbucket.org/inferno-os/inferno-os
hg clone https://hg@bitbucket.org/dboddie/inferno-os/wiki inferno-wiki
```

We create a hosted environment based on the contents of the *inferno-os*
directory and use *dd* to create a hard disk image. 256M is a reasonable size
to start with:

```
#!bash

./inferno-wiki/tools/make-install-root.sh inferno-os hosted
dd if=/dev/zero of=disk.img bs=1M count=256
```

It should now be possible to run the *make-disk.sh* script. This runs various
other scripts from the *inferno-wiki/tools* directory to perform the steps
described above. It will automatically run *qemu* to format the hard disk
image, so be aware that a window will pop up when this happens.

```
#!bash

./inferno-wiki/tools/make-disk.sh inferno-os hosted disk.img
```

If it finishes successfully, it should print a message informing you that you
can run *qemu* or *qemu-system-i386* to test it in the following way:

```
#!bash

qemu -m 512M -drive file=disk.img -net user -net nic,model=rtl8139
qemu-system-i386 -m 512M -drive file=disk.img -net user -net nic,model=rtl8139
```

Hopefully, this should boot successfully to a console prompt after obtaining
an IP address and binding directories in the kfs subpartition into the root
filing system.

## Testing the network connection

We can test whether the system running in *qemu* is connected to the network
by running a command to fetch the main page of the Inferno site:

```
#!bash
dial -A tcp!www.inferno-os.org!80 { echo 'GET /'; cat >[1=2] }
```

This should return the HTML of the main page.
