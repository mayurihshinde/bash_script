#!/bin/bash

# Wrapper for filtering data from all modules, using ftselect

# v1.1	: Changed default filter to reject events within 25 microseconds instead of 40.
# SVN revision: $Rev: 559 $
# Last modified: $Date: 2015-11-27 17:14:33 +0530 (Fri, 27 Nov 2015) $

infile=$1
outfile=$2
filter=$3

if [[ ($# -lt 2) || ($# -gt 3) ]]
  then
    echo "Usage: filter_data.sh infile outfile [filter]"
    exit
fi

echo Input file: $infile
echo Output file: $outfile

if [[ $# -eq 2 ]]
  then
    filter=' ( phi .gt. 0.33 .and. phi .lt. 0.61 )'
    echo "No filter specified, using default:"
fi

echo Filter: $filter

if [ ! -f $infile ]
  then
    echo "Input file '$infile' not found - quitting!"
    echo "Usage: filter_data.sh infile outfile [filter]"
    exit
fi

if [ -f $outfile ]
  then
    echo "Output file '$outfile' already exists - quitting!"
    echo "Usage: filter_data.sh infile outfile [filter]"
    exit
fi

source /opt/heasoft/x86_64-unknown-linux-gnu-libc2.12/headas-init.sh && echo "Heasoft initialized"

fextract $infile[0] $outfile

echo "Quadrant A" $outfile.1_evt
echo $filter | ftselect $infile[1] $outfile.1_evt copyall=no
fappend $outfile.1_evt $outfile && rm -f $outfile.1_evt

echo "Quadrant B"
echo $filter | ftselect $infile[2] $outfile.2_evt copyall=no
fappend $outfile.2_evt $outfile && rm -f $outfile.2_evt

echo "Quadrant C"
echo $filter | ftselect $infile[3] $outfile.3_evt copyall=no
fappend $outfile.3_evt $outfile && rm -f $outfile.3_evt

echo "Quadrant D"
echo $filter | ftselect $infile[4] $outfile.4_evt copyall=no
fappend $outfile.4_evt $outfile && rm -f $outfile.4_evt

echo "Other extensions"
fappend $infile[5] $outfile
fappend $infile[6] $outfile
fappend $infile[7] $outfile
fappend $infile[8] $outfile
fappend $infile[9] $outfile
fappend $infile[10] $outfile
fappend $infile[11] $outfile
fappend $infile[12] $outfile
