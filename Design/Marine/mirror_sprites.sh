#! /bin/bash

# build each row of the sheet
for D in *; 
do
    if [ -d "${D}" ]; then
    	for F in ${D}/*.png; 
    	do
      	convert ${F} -flop ${F}_reverse.png
    	done
    fi
done
