#!/bin/sh

set -e

# See https://umdrive.memphis.edu/blstuart/htdocs/inf_native.html for context.

if [ -z $1 ]; then
    echo "Usage: `basename $0` <Inferno source directory>"
    exit 1
fi

export THIS_DIR=$PWD
THIS_FILE=`realpath $0`

export INFERNO_ROOT=`realpath $1`
export INFERNO_TOOLS=`dirname $THIS_FILE`
export SYSHOST=Linux
export OBJTYPE=386

# Copy the custom mkconfig file into the source installation.
cp -f $INFERNO_TOOLS/config/mkconfig $INFERNO_ROOT/
# Copy the fdinit.sh file into the source installation so that it can be built
# into the kernel image.
cp $INFERNO_TOOLS/scripts/fdinit.sh $INFERNO_ROOT/init.sh
# Copy the new configuration into the source installation.
cp -f $INFERNO_TOOLS/config/pcboot $INFERNO_ROOT/os/pc/
cp -f $INFERNO_TOOLS/init/initpcbase.b $INFERNO_ROOT/os/init/

cd $INFERNO_ROOT
./makemk.sh 

export PATH=$INFERNO_ROOT/$SYSHOST/$OBJTYPE/bin:$PATH
sed -i s/'-fno-aggressive-loop-optimizations'// mkfiles/mkfile-Linux-386 
mkdir -p Inferno/386/lib
mk install

cd $INFERNO_ROOT/os/boot/pc/
mk mbr.install pbs.install pbslba.install 9load.install
cd $INFERNO_ROOT

cd $INFERNO_ROOT/os/pc
echo 'bootfile=fd0!ipc.gz' > plan9.ini
mk CONF=pcboot
mv ipcboot ipc
gzip -f -9 ipc
cd $INFERNO_ROOT

echo "cd os/pc" > $INFERNO_ROOT/os/pc/make-disk.sh
echo "disk/format -b /Inferno/386/pbs -df disk /Inferno/386/9load plan9.ini ipc.gz /Inferno/386/mbr /Inferno/386/pbslba" >> $INFERNO_ROOT/os/pc/make-disk.sh
#echo "disk/format -b /Inferno/386/pbs -df disk /Inferno/386/9load plan9.ini ipc.gz" >> $INFERNO_ROOT/os/pc/make-disk.sh

set +e
emu /dis/sh.dis os/pc/make-disk.sh
set -e

#echo "You can test the image with the following command:"
#echo "qemu -m 512M -fda $INFERNO_ROOT/os/pc/disk -boot a"
