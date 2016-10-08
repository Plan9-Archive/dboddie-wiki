#!/bin/bash

set -e

if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: `basename $0` <Inferno source directory> <supplementary tools directory>"
    exit 1
fi

export THIS_DIR=$PWD

export INFERNO_ROOT=`realpath $1`
export SYSHOST=Linux
export OBJTYPE=386

export INFERNO_TOOLS=`realpath $2`

# Copy the init.sh file into the source installation so that it can be built
# into the kernel image.
cp $INFERNO_TOOLS/scripts/init.sh $INFERNO_ROOT/init.sh
# Copy the new configuration into the source installation.
cp -f $INFERNO_TOOLS/config/pcbase $INFERNO_ROOT/os/pc/
cp -f $INFERNO_TOOLS/init/initpcbase.b $INFERNO_ROOT/os/init/

export PATH=$INFERNO_ROOT/$SYSHOST/$OBJTYPE/bin:$PATH

cd $INFERNO_ROOT/os/pc
mk CONF=pcbase
mv ipcbase ipc
gzip -9 -f ipc

cd $INFERNO_ROOT/os/boot/pc/
mk 9load.install mbr.install pbslba.install
