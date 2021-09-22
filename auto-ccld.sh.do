#!/usr/bin/env sh
temptarg=$3
permtarg=$1
src=$2
redo-ifchange conf-cc conf-ld warn-auto.sh

( cat warn-auto.sh; \
echo CC=\'`head -n 1 conf-cc`\'; \
echo LD=\'`head -n 1 conf-ld`\' \
) > auto-ccld.sh

