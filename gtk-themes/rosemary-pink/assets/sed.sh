#!/bin/sh
sed -i \
         -e 's/#1e2021/rgb(0%,0%,0%)/g' \
         -e 's/#f9f5d7/rgb(100%,100%,100%)/g' \
    -e 's/#3C3836/rgb(50%,0%,0%)/g' \
     -e 's/#d3859b/rgb(0%,50%,0%)/g' \
     -e 's/#282828/rgb(50%,0%,50%)/g' \
     -e 's/#f9f5d7/rgb(0%,0%,50%)/g' \
	"$@"