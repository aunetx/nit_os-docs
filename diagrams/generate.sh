#!/bin/bash

set -e

EXT="png"
DIR=$(dirname "$0")

# Replace output dir if `--no_rm` is not set
if ! [ "$1" == "--no_rm" ]; then
    echo "Removing $DIR/out..."
    rm -rf "$DIR/out" && mkdir "$DIR/out"
fi

echo "Generating diagrams from $DIR/src to $DIR/out..."

# Generate image from mermaid files
for source in "$DIR"/src/*; do
    # get name of file
    name=$(basename -- "$source")
    # verify that it is a file with extension ".mmd"
    if ! [ -d "$source" ] && [ "${name: -4}" == ".mmd" ]; then
        echo "Processing $source..."
        # generate file to outputs dir
        mmdc \
            -i "$source" \
            -o "$DIR/out/${name:: -4}.$EXT" \
            -b transparent \
            -t forest \
            -C "$DIR/style.css"
    fi
done

echo "done"