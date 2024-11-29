#!/bin/bash

realname=$(basename $(realpath Letter.tex) .tex)

latexmk -C
latexmk Letter 

cd Subfiles

./Subfiles.sh

cd ..

latexmk -c
pdftotext Letter.pdf ../PhD-RecLetters-private/$realname.pdftotext
