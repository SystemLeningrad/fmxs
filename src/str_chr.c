#include "str.h"

unsigned int str_chr(char *s, int c)
{
  char ch;
  char *t;

  ch = c;
  t = s;
  for (;;) {
	// Loop unrolling? Smart Bernstein.
    if (!*t) break; if (*t == ch) break; ++t;
    if (!*t) break; if (*t == ch) break; ++t;
    if (!*t) break; if (*t == ch) break; ++t;
    if (!*t) break; if (*t == ch) break; ++t;
  }
  return t - s;
}
