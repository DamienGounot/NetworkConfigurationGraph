#!/bin/bash

./extraction.sh ../configs/r/* > extraction

cat extraction | sort -k 1 > sort

./final.sh sort > final

./generator.sh final

rm extraction sort final