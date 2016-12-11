# Inferno

This Wiki aims to provide instructions for configuring, building and installing
Inferno on various devices, as well as information about the build system, boot
process, device drivers and file system layout. The focus is on running Inferno
on real hardware rather than as a hosted environment on some other operating
system.

## Overview

Inferno 

1. [Downloading the Inferno sources](Downloading the Inferno Sources)
2. [Building a Hosted Environment](Building a Hosted Inferno Environment)
3. [Configuring a Native Build](Configuring a Native Build)
4. [Building a PC Disk Image](Building a PC Disk Image)

Build Configuration

1. [Build configuration files](Build Configuration Files)

## Ports

The following is a list of native ports of Inferno to various devices with
source code publicly available:

* [Marvell Kirkwood/Sheevaplug](https://bitbucket.org/mjl/inferno-kirkwood)
* [Nintendo DS](https://bitbucket.org/mjl/inferno-ds)
* [OpenMoko Neo Freerunner](https://code.google.com/archive/p/inferno-openmoko/)
* [Raspberry Pi](https://bitbucket.org/infpi/inferno-rpi)

## Cloning this Wiki

This Wiki is written in [Markdown](http://daringfireball.net/projects/markdown/) syntax and stored in a Mercurial repository. You can use Mercurial to clone it:
```
$ hg clone https://dboddie@bitbucket.org/dboddie/inferno-os/wiki
```
