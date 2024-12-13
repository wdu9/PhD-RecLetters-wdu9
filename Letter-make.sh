#!/bin/bash

name=Letter
[[ -L "Letter.tex" ]] && nametex="$(basename $(realpath Letter.tex))" && name="${nametex%.*}"

echo "Processing $name"

latexmk -C
cd Subfiles

./Subfiles.sh

cd ..

pdflatex $name
bibtex   $name
pdflatex $name
pdflatex $name

cp -p $name.pdf ../PhD-RecLetters-private/$name.pdf
pdftotext $name.pdf ../PhD-RecLetters-private/$name.pdftotext
open ../PhD-RecLetters-private/$name.pdf

cat ../PhD-RecLetters-private/$name.pdftotext
