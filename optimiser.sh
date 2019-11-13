#!/bin/bash

function delete_larger_file {
    size1=$(stat -f%z $1)
    size2=$(stat -f%z $2)
    if [ $size1 -gt $size2 ]
    then
        rm $1
    else
        rm $2
    fi
}

IN_DIR=~/Desktop/test/imageset/*
OUT_DIR=~/Desktop/test/optimised/

export LC_ALL=en_US.UTF-8
for pathToFile in $IN_DIR
do
    fileName=$(basename ${pathToFile%.*})
    echo "processing $fileName"
    webpPath=$OUT_DIR$fileName.webp
    pngPath=$OUT_DIR$fileName.png
    vips webpsave $pathToFile $webpPath --Q=90 --min-size=true --reduction-effort=6 --strip=true
    vips pngsave $pathToFile $pngPath --Q=90 --compression=9 --strip=true

    delete_larger_file $webpPath $pngPath
done
