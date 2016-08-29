# Building a Hosted Inferno Environment

Inferno can be built as either a native operating system, running directly on hardware, or as an environment
that is hosted by another operating system. Although we want to build a native version of Inferno, we need to
build a hosted environment in order to prepare the resources needed by a native version.

We refer to the native version of Inferno as the **target** and the machine we use to compile it as the
**host**.

## Fetching build dependencies

When building on Debian GNU/Linux, some development packages will need to be installed. In addition, amd64
architecture hosts need to enable multiarch and i386 support. This can be done with the following commands:
```
#!bash

dpkg --add-architecture i386
apt-get update
add-get install multiarch-support libc6-dev-i386 libx11-dev:i386 libxext-dev:i386
```

This enables a 32-bit build of the hosted environment to be compiled and run on the host.

## Configuring the Hosted Build

At the command line, enter the *inferno-os* directory. The *mkconfig* file contains information about the
host and the target, such as the processor architecture and the location of the root of the sources.
Since we will initially create a hosted environment, we define the architectures to be the same. For example,
when compiling under GNU/Linux on i386 or amd64, replace the original definitions for *ROOT*, *SYSHOST* and *OBJTYPE* in the *mkconfig* file with the following:
```
#!bash

# In the mkconfig file:
ROOT=$INFERNO_ROOT
SYSHOST=$SYSHOST
OBJTYPE=$OBJTYPE
```

We can now, from the *inferno-os* directory, build the *mk* tool for the **host** with these commands:
```
#!bash

export INFERNO_ROOT=$PWD
export SYSHOST=Linux
export OBJTYPE=386
./makemk.sh
```

This should produce lots of compiler output but, if successful, finish with the following message:
```
mk binary built successfully!
```

We can now build the environment, but first we need to ensure that the *mk* tool we have created can be found
during the build. From the same *inferno-os* directory as before, run the following commands:
```
#!bash

export PATH=$INFERNO_ROOT/$SYSHOST/$OBJTYPE/bin:$PATH
sed -i s/'-fno-aggressive-loop-optimizations'// mkfiles/mkfile-$SYSHOST-$OBJTYPE
mkdir Inferno/$OBJTYPE/lib
mk install
```
The hosted environment is almost ready to use. Before trying it, we need to create a couple of directories:
```
#!bash

cp -r usr/inferno usr/$USER
mkdir tmp
```

Now you can test it by running the following command:
```
#!bash

emu 'wm/wm'
```

This should open a window showing Inferno's graphical environment which you can explore if you like. Simply
close the window when you are finished.

## Creating a separate installation

It can be confusing to have all the source directories in the root directory of the hosted environment.
To resolve this, run [the make-install-root.sh script](make-install-root.sh) script, passing the locations of the *inferno-os* directory and the new directory that will host the environment, as in the following example:
```
#!bash

make-install-root.sh $INFERNO_ROOT hosted
```