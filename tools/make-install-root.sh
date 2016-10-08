#!/bin/sh

set -e

if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: `basename $0` <source installation directory> <hosted installation directory>"
    exit 1
fi

# This is used if you want to run emu from within an installation directory.
echo "Creating $2 from $1"

mkdir -p $2
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

cp -r $1/appl $2/
cp -r $1/dis $2/
cp -r $1/fonts $2/
cp -r $1/icons $2/
cp -r $1/keydb $2/
cp -r $1/lib $2/
cp -r $1/man $2/
cp -r $1/services $2/
cp -r $1/usr $2/
cp -r $1/usr/inferno/lib $2/usr/$USER/

cd $2
echo "Now run \"emu -r $2\" to try the installation."
