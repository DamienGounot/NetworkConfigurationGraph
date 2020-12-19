#!/bin/bash
./extraction.sh ../configs/cat/* > extraction
cat extraction | tr ',' ' ' > extraction_space
./duplicate.sh extraction_space > duplicate
./allowed.sh duplicate > allowed
./process.sh allowed > process
./generator.sh process
rm extraction extraction_space duplicate allowed process
