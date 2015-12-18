#!/bin/bash

for file in $@
do
    dirName=$(   dirname $file)
    fileName=$(  basename $file)
    fileExt=$(   echo $fileName | cut -f 2- -d. )
    hash=$( md5sum $file | cut -f 1 -d\  )
    newFName=$hash.$fileExt
    if [[ "$fileName" != "$newFName" ]]
    then
	mv -i $file $dirName/$newFName
    fi
done
