#!/bin/bash

./extraction.sh ../configs/pe/* > extraction

cat extraction | grep export | sort -k 3 > export
cat extraction | grep import | sort -k 3 > import
join -1 3 -2 3 export import > join
./generator.sh ./join
rm extraction export import join