#!/usr/bin/env python

import sys

def read_text(f):

    t = ""
    while True:
    
        b = f.read(1)
        if b == "\x00":
            break
        
        t += b
    
    return t

if __name__ == "__main__":

    if len(sys.argv) != 4:
        sys.stderr.write("Usage: %s <disk image> <output FAT image> <output fs image>\n" % sys.argv[0])
        sys.exit(1)
    
    disk_image = sys.argv[1]
    fat_image = sys.argv[2]
    fs_image = sys.argv[3]
    
    f = open(disk_image, "rb")
    f.seek(0x4200, 0)
    
    t = read_text(f)
    #print t
    lines = t.split("\n")
    
    # Find the 9fat and fs subpartitions.
    subpartitions = {"9fat": None, "fs": None}
    
    for line in lines:
    
        if line.startswith("part "):
            pieces = line.split()
            name = pieces[1]
            if name in subpartitions:
                subpartitions[name] = int(pieces[2])
    
    if subpartitions["9fat"] is None or subpartitions["fs"] is None:
        sys.stderr.write("Subpartitions not found in '%s'.\n" % disk_image)
        sys.exit(1)
    
    fat_offset = (32 + subpartitions["9fat"]) * 512
    fs_offset = (32 + subpartitions["fs"]) * 512
    #print hex(fs_offset)
    
    f.seek(fs_offset + 0x100, 0)
    t = read_text(f)
    
    if not t.startswith("kfs wren device"):
        sys.stderr.write("kfs subpartition not found in '%s'.\n" % disk_image)
        sys.exit(1)
    
    f.seek(fat_offset, 0)
    open(fat_image, "wb").write(f.read(fs_offset - fat_offset))
    print "Written", fat_image
    
    f.seek(fs_offset, 0)
    open(fs_image, "wb").write(f.read())
    print "Written", fs_image
    
    sys.exit()
