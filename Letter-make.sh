#!/bin/bash


latexmk -C
latexmk Letter 
bibtex Letter
latexmk Letter 


cd Subfiles

./Subfiles.sh

cd ..

latexmk -c

[[ -L "Letter.tex" ]] && nametex="$(basename $(realpath Letter.tex))" && name="${nametex%.*}" && echo "$name"

cp -p Letter.pdf ../PhD-RecLetters-private/$name.pdf
pdftotext $name.pdf ../PhD-RecLetters-private/$name.pdftotext
open ../PhD-RecLetters-private/$name.pdf

cat ../PhD-RecLetters-private/$name.pdftotext
