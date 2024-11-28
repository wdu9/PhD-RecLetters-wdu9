#!/bin/bash

latexmk -C
latexmk Letter 

cd Subfiles

./Subfiles.sh

cd ..

latexmk -c
pdftotext Letter.pdf ../PhD-RecLetters-private/Letter.pdftotext
