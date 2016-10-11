#!/bin/sh

set -e

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
    echo "Usage: `basename $0` <Inferno source directory> <hosted installation directory> <disk image>"
    exit 1
fi

export THIS_DIR=$PWD
THIS_FILE=`realpath $0`

export INFERNO_ROOT=`realpath $1`
export INFERNO_TOOLS=`dirname $THIS_FILE`
export INFERNO_HOSTED_ROOT=`realpath $2`
export DISK_IMAGE=`realpath $3`

export SYSHOST=Linux
export OBJTYPE=386

$INFERNO_TOOLS/build-pc-boot.sh $INFERNO_ROOT $INFERNO_TOOLS

qemu -m 512M -fda $INFERNO_ROOT/os/pc/disk -hda $DISK_IMAGE -boot a

mkdir -p $INFERNO_HOSTED_ROOT/fsdisk/9fat
mkdir -p $INFERNO_HOSTED_ROOT/fsdisk/fs

$INFERNO_TOOLS/extract_fs.py $DISK_IMAGE $INFERNO_HOSTED_ROOT/fsdisk/9fat.part \
                            $INFERNO_HOSTED_ROOT/fsdisk/fs.part

$INFERNO_TOOLS/build-pc.sh $INFERNO_ROOT $INFERNO_TOOLS $INFERNO_HOSTED_ROOT

# Copy files into the hosted root so that the tools run using emu can access
# them, copying them into the the FAT or KFS file systems.
echo 'bootfile=sdC0!9fat!ipc.gz' > $INFERNO_HOSTED_ROOT/fsdisk/9fat/plan9.ini
cp $INFERNO_ROOT/os/boot/pc/9load $INFERNO_HOSTED_ROOT/fsdisk/9fat/
cp $INFERNO_ROOT/os/pc/ipc.gz $INFERNO_HOSTED_ROOT/fsdisk/9fat/

# Copy files into the hosted installation.
cp $INFERNO_TOOLS/scripts/fill-9fat.sh $INFERNO_HOSTED_ROOT/fsdisk/
cp $INFERNO_TOOLS/scripts/fill-kfs.sh $INFERNO_HOSTED_ROOT/fsdisk/

set +e
# Copy the 9fat and kfs directories into the pre-installation disk image.
$INFERNO_ROOT/$SYSHOST/$OBJTYPE/bin/emu -c1 -r $INFERNO_HOSTED_ROOT sh.dis /fsdisk/fill-9fat.sh
$INFERNO_ROOT/$SYSHOST/$OBJTYPE/bin/emu -c1 -r $INFERNO_HOSTED_ROOT sh.dis /fsdisk/fill-kfs.sh
set -e

dd if=$DISK_IMAGE of=$INFERNO_HOSTED_ROOT/fsdisk/start.img bs=512 count=32 
cat $INFERNO_HOSTED_ROOT/fsdisk/start.img $INFERNO_HOSTED_ROOT/fsdisk/9fat.part $INFERNO_HOSTED_ROOT/fsdisk/fs.part > disk.img

echo "Disk image 'disk.img' created."
echo "You can test the image with the following command:"
echo "qemu -m 512M -drive file=disk.img -net user -net nic,model=rtl8139"
