#!/bin/sh

# usage: mkview.sh <filename> <width> <height>

povray +L/home/ksz/eagle/3d/eagle3d/povray +I$1.pov +O$1.png +W$2 +H$3
