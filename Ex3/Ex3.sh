#!/bin/bash

./extraction.sh ../configs/conf/* > extraction
awk '{print > $1".split"}' extraction
./concat.sh ./*.split > concat
./final.sh concat > final
./generator.sh final
rm extraction *.split concat final