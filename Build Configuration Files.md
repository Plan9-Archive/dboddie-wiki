# Build Configuration Files

Builds of Inferno are configured using the configuration files stored in each subdirectory of the *os* directory. Each file is typically given the same name as their parent directory - for example, *os/pc/pc* - but the configuration file can be identified by looking in the *mkfile* for the definition of the `CONF` variable.

Each configuration file lists the features that will be built into the kernel, defines aspects of its behaviour, specifies the devices and libraries that will be available to it, lists the contents of the root filesystem, and enables the system to be configured in other ways. The file is split up into sections that cover each of these areas. Lines in the file are ignored if they begin with `#` characters.

Each section contains lines that are either commented out or contain information about a configuration component. The latter begin with a tab character and contain one or more strings separated by more tab characters.

## dev

The `dev` section lists the devices that will be available to the kernel. Each of these corresponds to a driver that will be built into the kernel.

## lib

The `lib` section lists the libraries that will be built into the kernel. These include fundamental ones, such as `kern` and `interp`, as well as those that are only needed for graphical installations, such as `draw` and `tk`.

## link

The `link` section lists the network devices to be included in the build. Each device is specified on a single line containing the name of the driver and, optionally, the interface used by the device. If both of these are specified, the strings are separated by a tab character.