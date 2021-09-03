#include "hier.h"

#include <sys/types.h>
#include "auto_qmail.h"
#include "auto_split.h"
#include "auto_uids.h"
#include "fmt.h"
#include "fifo.h"

char buf[100 + FMT_ULONG];

void dsplit(char *base, /* must be under 100 bytes */
            uid_t uid, int mode)
{
  char *x;
  unsigned long i;

  d(auto_qmail,base,uid,auto_gidq,mode);

  for (i = 0;i < auto_split;++i) {
    x = buf;
    x += fmt_str(x,base);
    x += fmt_str(x,"/");
    x += fmt_ulong(x,i);
    *x = 0;

    d(auto_qmail,buf,uid,auto_gidq,mode);
  }
}

void hier_queue()
{
  d(auto_qmail,"queue",auto_uidq,auto_gidq,0750);
  d(auto_qmail,"queue/pid",auto_uidq,auto_gidq,0700);
  d(auto_qmail,"queue/intd",auto_uidq,auto_gidq,0700);
  d(auto_qmail,"queue/todo",auto_uidq,auto_gidq,0750);
  d(auto_qmail,"queue/bounce",auto_uids,auto_gidq,0700);

  dsplit("queue/mess",auto_uidq,0750);
  dsplit("queue/info",auto_uids,0700);
  dsplit("queue/local",auto_uids,0700);
  dsplit("queue/remote",auto_uids,0700);

  d(auto_qmail,"queue/lock",auto_uidq,auto_gidq,0750);
  z(auto_qmail,"queue/lock/tcpto",1024,auto_uidr,auto_gidq,0644);
  z(auto_qmail,"queue/lock/sendmutex",0,auto_uids,auto_gidq,0600);
  p(auto_qmail,"queue/lock/trigger",auto_uids,auto_gidq,0622);
}

void hier()
{
  h(auto_qmail,auto_uido,auto_gidq,0755);

  d(auto_qmail,"control",auto_uido,auto_gidq,0755);
  d(auto_qmail,"users",auto_uido,auto_gidq,0755);
  d(auto_qmail,"bin",auto_uido,auto_gidq,0755);
  d(auto_qmail,"boot",auto_uido,auto_gidq,0755);
  d(auto_qmail,"doc",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/cat1",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/cat5",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/cat7",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/cat8",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/man1",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/man5",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/man7",auto_uido,auto_gidq,0755);
  d(auto_qmail,"man/man8",auto_uido,auto_gidq,0755);

  d(auto_qmail,"alias",auto_uida,auto_gidq,02755);

  hier_queue();

  c(auto_qmail,"boot","boot","home",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","home+df",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","proc",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","proc+df",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","binm1",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","binm1+df",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","binm2",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","binm2+df",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","binm3",auto_uido,auto_gidq,0755);
  c(auto_qmail,"boot","boot","binm3+df",auto_uido,auto_gidq,0755);

  c(auto_qmail,"doc","doc","FAQ.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","UPGRADE.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","SENDMAIL.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.alias.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.ctl.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.ids.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.maildir.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.mbox.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","INSTALL.vsm.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","TEST.deliver.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","TEST.receive.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","REMOVE.sendmail.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","REMOVE.binmail.md",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.local2alias",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.local2ext",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.local2local",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.local2rem",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.local2virt",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.nullclient",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.relaybad",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.relaygood",auto_uido,auto_gidq,0644);
  c(auto_qmail,"doc","doc","PIC.rem2local",auto_uido,auto_gidq,0644);

  c(auto_qmail,"bin","src","qmail-queue",auto_uidq,auto_gidq,04711);
  c(auto_qmail,"bin","src","qmail-lspawn",auto_uido,auto_gidq,0700);
  c(auto_qmail,"bin","src","qmail-start",auto_uido,auto_gidq,0700);
  c(auto_qmail,"bin","src","qmail-getpw",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-local",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-remote",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-rspawn",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-clean",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-send",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","splogger",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-newu",auto_uido,auto_gidq,0700);
  c(auto_qmail,"bin","src","qmail-newmrh",auto_uido,auto_gidq,0700);
  c(auto_qmail,"bin","src","qmail-pw2u",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-inject",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","predate",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","datemail",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","mailsubj",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-showctl",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-qread",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-qstat",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-tcpto",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-tcpok",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-pop3d",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-popup",auto_uido,auto_gidq,0711);
  c(auto_qmail,"bin","src","qmail-qmqpc",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-qmqpd",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-qmtpd",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qmail-smtpd",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","sendmail",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","tcp-env",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qreceipt",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","qbiff",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","forward",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","preline",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","condredirect",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","bouncesaying",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","except",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","maildirmake",auto_uido,auto_gidq,0755);
  c(auto_qmail,"bin","src","maildir2mbox",auto_uido,auto_gidq,0755);

  c(auto_qmail,"man/man5","doc/man","addresses.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","addresses.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","envelopes.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","envelopes.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","maildir.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","maildir.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","mbox.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","mbox.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","dot-qmail.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","dot-qmail.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","qmail-control.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","qmail-control.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","qmail-header.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","qmail-header.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","qmail-log.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","qmail-log.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","qmail-users.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","qmail-users.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man5","doc/man","tcp-environ.5",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat5","doc/man","tcp-environ.0",auto_uido,auto_gidq,0644);

  c(auto_qmail,"man/man7","doc/man","forgeries.7",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat7","doc/man","forgeries.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man7","doc/man","qmail-limits.7",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat7","doc/man","qmail-limits.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man7","doc/man","qmail.7",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat7","doc/man","qmail.0",auto_uido,auto_gidq,0644);

  c(auto_qmail,"man/man1","doc/man","forward.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","forward.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","condredirect.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","condredirect.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","bouncesaying.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","bouncesaying.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","except.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","except.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","maildirmake.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","maildirmake.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","maildir2mbox.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","maildir2mbox.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","mailsubj.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","mailsubj.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","qreceipt.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","qreceipt.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","qbiff.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","qbiff.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","preline.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","preline.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man1","doc/man","tcp-env.1",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat1","doc/man","tcp-env.0",auto_uido,auto_gidq,0644);

  c(auto_qmail,"man/man8","doc/man","qmail-local.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-local.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-lspawn.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-lspawn.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-getpw.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-getpw.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-remote.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-remote.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-rspawn.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-rspawn.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-clean.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-clean.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-send.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-send.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-start.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-start.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","splogger.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","splogger.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-queue.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-queue.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-inject.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-inject.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-showctl.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-showctl.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-newmrh.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-newmrh.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-newu.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-newu.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-pw2u.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-pw2u.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-qread.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-qread.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-qstat.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-qstat.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-tcpok.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-tcpok.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-tcpto.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-tcpto.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-pop3d.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-pop3d.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-popup.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-popup.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-qmqpc.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-qmqpc.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-qmqpd.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-qmqpd.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-qmtpd.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-qmtpd.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-smtpd.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-smtpd.0",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/man8","doc/man","qmail-command.8",auto_uido,auto_gidq,0644);
  c(auto_qmail,"man/cat8","doc/man","qmail-command.0",auto_uido,auto_gidq,0644);
}
