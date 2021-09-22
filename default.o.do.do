#!/usr/bin/env sh
temptarg=$3
permtarg=$1
src=$2
# creates default.o.do; requires auto-ccld ??
#redo-ifchange conf-cc conf-ld warn-auto.sh auto-ccld.sh
redo-ifchange conf-cc conf-ld warn-auto.sh

(
cat warn-auto.sh
cat << EOF
temptarg=\$3
permtarg=\$1
src=\$2
EOF
echo CC=\'`head -n 1 conf-cc`\'
echo LD=\'`head -n 1 conf-ld`\'
echo \$\{CC\} -c -o \$3 \$1
) > $3

