#!/bin/sh

# Usage:  convert a b; convert .a to .b
# for example, .com to .gjf of Gaussian09
# Can also convert jpg to png if ffmpeg is installed.

if [ $1 = "jpg" | $1 = "png" ]; then
	if [ "`which ffmpeg`" = "" ]; then
		echo "ffmpeg is not installed!"
	else
		echo "converting using ffmpeg"
		for i in *.$1;do ffmpeg -i "$i" -vf scale=1200:800 "${i%.$1}.$2";done
	fi
else 
	echo "only change the suffix name"
	for i in *.$1;do mv $i ${i%.$1}.$2; done
fi
