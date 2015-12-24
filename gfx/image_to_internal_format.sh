#!/bin/bash

# Ugh, uhm, I guess this only works on GNU.
# And ImageMagick is required.

img=$1
metadata="$img".h

cat "$metadata"
echo
echo 'static unsigned int dec_img[] = {'

convert -quiet -compress lossless -depth 8 "$img" ppm:- |
sed '1,3d' |
od -vt x1 -w3 -An |
sed 's/^/0xff/' |
sed 's/ //g' |
paste -sd, |
sed 's/,/, /g' |
fold -sw 72

echo '};'
