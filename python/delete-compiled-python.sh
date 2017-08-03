#!/bin/sh

if [ $# -ge 1 ]; then
    path="$1"
else
    path="./"
fi

echo "Delete *.pyc in ${path}"
find $path -name \*.pyc -delete
echo "Delete __pycache__ in ${path}"
find $path -name __pycache__ -delete