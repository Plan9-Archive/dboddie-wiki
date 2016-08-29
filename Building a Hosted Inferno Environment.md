# Building a Hosted Inferno Environment

Inferno can be built as either a native operating system, running directly on hardware, or as an environment
that is hosted by another operating system. Although we want to build a native version of Inferno, we need to
build a hosted environment in order to prepare the resources needed by a native version.

We refer to the native version of Inferno as the **target** and the machine we use to compile it as the
**host**.

## Fetching Build Dependencies

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
when compiling under GNU/Linux on i386 or amd64, replace the original definitions in the *mkconfig* file with the following:
```
#!bash

ROOT=$PWD
SYSHOST=Linux
OBJTYPE=386
```

We can now, from the *inferno-os* directory, build the *mk* tool for the **host**:
```
#!bash

./makemk.sh
```

This should produce lots of compiler output but, if successful, finish with the following message:
```
mk binary built successfully!
```

We can now build the environment, but first we need to ensure that the *mk* tool we have created can be found
during the build. From the same *inferno-os* directory as before, run the following commands :
```
export PATH=$PWD/Linux/386/bin:$PATH
mk all
```
