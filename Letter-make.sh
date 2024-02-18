#!/bin/bash

latexmk -C
latexmk Letter 

cd Subfiles

./Subfiles.sh

cd ..

latexmk -c
