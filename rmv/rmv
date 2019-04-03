#!/bin/sh
# ~/.Trash is the default Trash Folder path of MacOS.
# Wildcard "*" is supported.
# The deletion date and time are recorded, for example, when deleting at date 03-01,2019 and time 12:13:14, then the deleted file or folder "a.f" is renamed as "a.f20190301121314"
# Time is in 24-hour format, with seconds.

dirpath=$HOME/.Trash 
for i in $*; do
full_date=`date "+%Y%m%d%H%M%S"`
filename=`basename $i`
/bin/mv $i ${dirpath}/$filename.$full_date
done
