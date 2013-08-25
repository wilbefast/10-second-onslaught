#! /bin/bash

# build each row of the sheet
COUNTER=0
for D in *; do
    if [ -d "${D}" ]; then
        montage ${D}/*.png -geometry 270x700+0+0 -tile 7x1 -background none ${D}.png
        COUNTER=$[$COUNTER +1]
    fi
done

# assemble rows into the sheet
#montage *.png -geometry 1890x700+0+0 -tile 1x$COUNTER -background none OUT.png

# remove temporary row files
#for D in *; do
#    if [ -d "${D}" ]; then
#        rm ./${D}.png
#    fi
#done

