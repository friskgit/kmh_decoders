#!/bin/bash

source="~/Music/faust/faust_stuff.git/Makefile.faust"
target=$1

if [ $target ]; then
    echo "Update makefile from $source..."
    cp $source $target/Makefile
else
    echo "You need to specify a target directory."
fi
   

