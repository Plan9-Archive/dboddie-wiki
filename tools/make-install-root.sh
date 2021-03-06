#!/bin/sh

set -e

if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: `basename $0` <source installation directory> <hosted installation directory> [--with-src]"
    exit 1
fi

# This script is used if you want to run emu from within an installation
# directory or want to prepare a file system for a disk image.

export THIS_DIR=$PWD
THIS_FILE=`realpath $0`

export INFERNO_ROOT=`realpath $1`
export INFERNO_TOOLS=`dirname $THIS_FILE`

echo "Creating $2 from $1"

mkdir -p $2
mkdir -p $2/mail
mkdir -p $2/n/cd
mkdir -p $2/n/client/chan
mkdir -p $2/n/client/dev
mkdir -p $2/n/disk
mkdir -p $2/n/dist
mkdir -p $2/n/dos
mkdir -p $2/n/dump
mkdir -p $2/n/ftp
mkdir -p $2/n/gridfs
mkdir -p $2/n/kfs
mkdir -p $2/n/local
mkdir -p $2/n/rdbg
mkdir -p $2/n/registry
mkdir -p $2/n/remote
mkdir -p $2/tmp
mkdir -p $2/usr/$USER

cp -r $1/acme $2/
cp -r $1/appl $2/
cp -r $1/dis $2/
cp -r $1/doc $2/
cp -r $1/fonts $2/
cp -r $1/icons $2/
cp -r $1/keydb $2/
cp -r $1/lib $2/
cp -r $1/locale $2/
cp -r $1/man $2/
cp -r $1/module $2/
cp -r $1/services $2/
cp -r $1/usr $2/
cp -r $1/usr/inferno/lib $2/usr/$USER/

#cd $2
#echo "Now run \"emu -r $2\" to try the installation."

export INFERNO_HOSTED_ROOT=`realpath $2`

if [ -n $3 ] && [ "$3" = '--with-src' ]; then
    echo "Archiving $1 to $INFERNO_HOSTED_ROOT/usr/inferno-os.tgz"
    cd $INFERNO_ROOT
    hg archive -t tgz $INFERNO_HOSTED_ROOT/doc/inferno-os.tgz
    cd $INFERNO_TOOLS
    hg archive -t tgz $INFERNO_HOSTED_ROOT/doc/inferno-wiki.tgz
fi
