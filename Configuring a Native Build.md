# Configuring a Native Build

With environment variables set up as described in [Building a Hosted Environment](Building a Hosted Environment),
we can configure a native build. Initially, we will build a native kernel for a 32-bit x86-based PC.

## Enter the port directory

For the native PC build, the directory containing much of the code specific to the platform is *inferno-os/os/pc*. From the root of the source distribution, enter this directory:
```
#!bash

cd os/pc
```

## References

This information is based on [How to Build a Native Inferno Kernel for the PC](http://umdrive.memphis.edu/blstuart/htdocs/inf_native.html) by Brian Stuart.