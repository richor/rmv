#!/bin/sh
# to use with rsync, since rsync cannot handle with space-containing filename
# change f to d to change the name of directory.
# directory can run several times to run like -R
# original version come from: https://www.cnblogs.com/kerrycode/p/7827118.html
find . -type f -name "* *" -print |
while read name; do
na=$(echo $name | tr ' ' '_')
if [[ $name != $na ]]; then
mv "$name" "$na"
fi
done
