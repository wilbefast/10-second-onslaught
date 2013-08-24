#! /bin/bash

# build each row of the sheet
for D in *; 
do
    if [ -d "${D}" ]; then
    	for F in ${D}/*.png; 
    	do
      	convert ${F} -flop ${D}/reverse_$(basename $F)
    	done
    fi
done
