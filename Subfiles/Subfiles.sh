#!/bin/bash

latexmk -C

for f in *.tex; do
    latexmk    "$f"
    latexmk -c "$f"
done


rm *.dep
