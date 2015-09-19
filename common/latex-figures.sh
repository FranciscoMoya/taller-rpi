#!/bin/bash
set -e

TEX=${1:-main.tex}
includegraphics=$(grep -v "^%" $TEX \
    | grep includegraphics \
    | sed "s/.*includegraphics.*{\([.a-zA-Z0-9_//\-]*\).*$/\1/g")

imagenmargen=$(grep -v "^%" $TEX \
    | grep imagenmargen \
    | sed "s/.imagenmargen{\([.a-zA-Z0-9_//\-]*\).*$/\1/g")

imagenhere=$(grep -v "^%" $TEX \
    | grep imagenhere \
    | sed "s/.imagenhere{\([.a-zA-Z0-9_//\-]*\).*$/\1/g")

imagenanchototal=$(grep -v "^%" $TEX \
    | grep imagenanchototal \
    | sed "s/.imagenanchototal{\([.a-zA-Z0-9_//\-]*\).*$/\1/g")

images="$includegraphics $imagenmargen $imagenhere $imagenanchototal"

echo $images | sort | uniq
