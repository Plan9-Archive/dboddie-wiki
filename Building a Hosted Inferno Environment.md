# Building a Hosted Inferno Environment

Inferno can be built as either a native operating system, running directly on hardware, or as an environment
that is hosted by another operating system. Although we want to build a native version of Inferno, we need to
build a hosted environment in order to prepare the resources needed by a native version.

We refer to the native version of Inferno as the **target** and the machine we use to compile it as the
**host**.

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