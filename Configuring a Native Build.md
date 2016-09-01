# Configuring a Native Build

With environment variables set up as described in [Building a Hosted Environment](Building a Hosted Environment),
we can configure a native build.

In principle, each of the platforms that can run Inferno natively is
represented by a subdirectory of the *inferno-os/os* directory. Using the tools
that were built when we created the hosted environment, it should be possible
to build a kernel for each of these platforms.

Initially, we will build a native kernel for a 32-bit x86-based PC.

## Enter the port directory

For the native PC build, the directory containing much of the code specific to
the platform is *inferno-os/os/pc*. From the root of the source distribution,
enter this directory:
```
#!bash

cd os/pc
```

For some reason the configuration file contains references to directories that
do not exist in the standard *inferno-os* source directory. Copy the
[fix-pc-build.py](tools/fix-pc-build.py) script into the current directory and run
it:
```
#!bash

python fix-pc-build.py pc
```

This modifies the *pc* configuration file, enabling the shell by default and
adding a couple of missing files. It should now be possible to build the kernel:
```
#!bash

mk
```

If successful, the end result should be a file called *ipc* in the current
directory. This needs to be compressed, and we also need to create a file that
will tell the bootloader where to find it:

```
#!bash

gzip -9 ipc
echo 'bootfile=fd0!ipc.gz' > plan9.ini
```

Some additional components are required to boot the kernel. We build these by
entering the *inferno-os/os/boot/pc* directory and running the mk tool:

```
#!bash

cd $INFERNO_ROOT/os/boot/pc/
mk pbs.install 9load.install
```

With these in place, the last thing to do is to construct a bootable image
containing the boot block, bootloader and kernel. We use the hosted environment
to do this:
```
#!bash

emu
```

In the hosted environment, execute the following commands to enter the
directory containing the PC version and create a disk image called *disk*:
```
cd os/pc
disk/format -b /Inferno/386/pbs -df disk /Inferno/386/9load plan9.ini ipc.gz
exit
```

The disk image can be tested using qemu:
```
#!bash

qemu -m 512M -fda $INFERNO_ROOT/os/pc/disk
```

This should boot to a shell prompt.

## References

This information is based on [How to Build a Native Inferno Kernel for the PC](http://umdrive.memphis.edu/blstuart/htdocs/inf_native.html) by Brian Stuart.
