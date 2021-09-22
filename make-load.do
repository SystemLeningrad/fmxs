#!/usr/bin/env sh
temptarg=$3
permtarg=$1
src=$2
redo-ifchange ${permtarg}.sh auto-ccld.sh

cat auto-ccld.sh ${permtarg}.sh > $temptarg
