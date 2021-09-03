echo 'main="$1"; shift'
echo exec "$LD" '-o "$main" "src/$main".o ${1+"$@"}'
