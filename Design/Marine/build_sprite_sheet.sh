#! /bin/bash

# build each row of the sheet
COUNTER=0
for D in *; do
    if [ -d "${D}" ]; then
        montage ${D}/*.png -geometry 48x48+0+0 -tile 10x1 -background none ${D}.png
        COUNTER=$[$COUNTER +1]
    fi
done

# assemble rows into the sheet
montage *.png -geometry 480x48+0+0 -tile 1x$COUNTER -background none OUT.png

# remove temporary row files
for D in *; do
    if [ -d "${D}" ]; then
        rm ./${D}.png
    fi
done

