#!/bin/bash
# Mayuri Shinde
# Version 1.0
# This script will take difference between /data2/czti/archive/ and /czti_ddn/czti/archive_backup/ directories and take a backup of archive in /czti_ddn/czti/archive_backup/. This script will be executed by cron tab at 2:00 am.

source="/data2/czti/archive/"
destination="/czti_ddn/czti/archive_backup/"

rsync -rlcv --dry-run $source $destination

#-v, --verbose               increase verbosity
#-c, --checksum              skip based on checksum, not mod-time & size
#-r, --recursive             recurse into directories
#-l, --links                 copy symlinks as symlinks
