#include "commands.h"

#include "substdio.h"
#include "stralloc.h"
#include "str.h"
#include "case.h"

static stralloc cmd = {0};

int commands (
 substdio *ss,
 struct commands *c
) {
  unsigned int i;
  char *arg;

  for (;;) {
	/* This isn't very optimized for the modern world.
	   It's basically a spinlock, only protected from
       going insane on your CPU by the fact that the
       socket is blocking.

       Even if we are only handling one socket in smtpd,
       that was 1997. This is 2021. We aren't doing that
       anymore. smtpd has to do iauth and, if it's running
       on the submission port, it has to do SASL too.
        ~ Amelia */
    if (!stralloc_copys(&cmd,"")) return -1;

    for (;;) {
      int j;
      if (!stralloc_readyplus(&cmd,1)) return -1;
      j = substdio_get(ss,cmd.s + cmd.len,1);
      if (j != 1) return j;
      if (cmd.s[cmd.len] == '\n') break;
      ++cmd.len;
    }

    if (cmd.len > 0) if (cmd.s[cmd.len - 1] == '\r') --cmd.len;

    cmd.s[cmd.len] = 0;

    i = str_chr(cmd.s,' ');
    arg = cmd.s + i;
    while (*arg == ' ') ++arg;
    cmd.s[i] = 0;

    for (i = 0;c[i].text;++i) if (case_equals(c[i].text,cmd.s)) break;
    c[i].fun(arg);
    if (c[i].flush) c[i].flush();
  }
}
