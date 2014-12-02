#!/bin/bash
# - makegif.sh
IFS="`printf '\n\t'`"

outfile=$(mktemp -p ./ "$(basename $(pwd))-XXX.gif")
tempdir=$(mktemp -d -p ./ resizedjpgs.XXX)

echo maing temp dir $tempdir

echo beginning for loop
for i in ./*jpg;
do
    echo resizing/padding file $i into $tempdir/$i;
    convert "$i" -resize 800x600 -background black -gravity center -extent 800x600 "./$tempdir/$i";
done

echo 'making animated gif from ./$tempdir/*jpg'
convert -delay 200 -loop 0 ./$tempdir/*jpg $outfile && \
  echo done writing $outfile

echo removing tempdir
rm -r $tempdir
