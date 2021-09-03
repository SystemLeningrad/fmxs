echo exec "$CC" -o '"${1%.?}.o"' -c '${1+"$@"}'
