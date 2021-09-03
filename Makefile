# Don't edit Makefile! Use conf-* for configuration.

SHELL=/bin/sh
NROFF?=nroff

default: it

.PHONY: check clean default it man test

.SUFFIXES: .0 .1 .5 .7 .8

.1.0:
	$(NROFF) -man $< >$@

.5.0:
	$(NROFF) -man $< >$@

.7.0:
	$(NROFF) -man $< >$@

.8.0:
	$(NROFF) -man $< >$@

doc/man/addresses.0: \
doc/man/addresses.5

auto-ccld.sh: \
conf-cc conf-ld warn-auto.sh
	( cat warn-auto.sh; \
	echo CC=\'`head -n 1 conf-cc`\'; \
	echo LD=\'`head -n 1 conf-ld`\' \
	) > auto-ccld.sh

auto-int: \
load src/auto-int.o src/substdio.a src/error.a src/str.a src/fs.a
	./load auto-int src/substdio.a src/error.a src/str.a src/fs.a 

src/auto-int.o: \
compile src/auto-int.c include/substdio.h include/readwrite.h include/exit.h include/scan.h include/fmt.h
	./compile src/auto-int.c

auto-int8: \
load src/auto-int8.o src/substdio.a src/error.a src/str.a src/fs.a
	./load auto-int8 src/substdio.a src/error.a src/str.a src/fs.a 

src/auto-int8.o: \
compile src/auto-int8.c include/substdio.h include/readwrite.h include/exit.h include/scan.h include/fmt.h
	./compile src/auto-int8.c

auto-str: \
load src/auto-str.o src/substdio.a src/error.a src/str.a
	./load auto-str src/substdio.a src/error.a src/str.a 

src/auto-str.o: \
compile src/auto-str.c include/substdio.h include/readwrite.h include/exit.h
	./compile src/auto-str.c

src/auto_break.c: \
auto-str conf-break
	./auto-str auto_break \
	"`head -n 1 conf-break`" > src/auto_break.c

src/auto_break.o: \
compile src/auto_break.c
	./compile src/auto_break.c

src/auto_patrn.c: \
auto-int8 conf-patrn
	./auto-int8 auto_patrn `head -n 1 conf-patrn` > src/auto_patrn.c

src/auto_patrn.o: \
compile src/auto_patrn.c
	./compile src/auto_patrn.c

src/auto_qmail.c: \
auto-str conf-qmail
	./auto-str auto_qmail `head -n 1 conf-qmail` > src/auto_qmail.c

src/auto_qmail.o: \
compile src/auto_qmail.c
	./compile src/auto_qmail.c

src/auto_spawn.c: \
auto-int conf-spawn
	./auto-int auto_spawn `head -n 1 conf-spawn` > src/auto_spawn.c

src/auto_spawn.o: \
compile src/auto_spawn.c
	./compile src/auto_spawn.c

src/auto_split.c: \
auto-int conf-split
	./auto-int auto_split `head -n 1 conf-split` > src/auto_split.c

src/auto_split.o: \
compile src/auto_split.c
	./compile src/auto_split.c

src/auto_usera.c: \
auto-str conf-users
	./auto-str auto_usera `head -n 1 conf-users` > src/auto_usera.c

src/auto_usera.o: \
compile src/auto_usera.c
	./compile src/auto_usera.c

src/auto_userd.c: \
auto-str conf-users
	./auto-str auto_userd `head -n 2 conf-users | tail -1` > src/auto_userd.c

src/auto_userd.o: \
compile src/auto_userd.c
	./compile src/auto_userd.c

src/auto_userl.c: \
auto-str conf-users
	./auto-str auto_userl `head -n 3 conf-users | tail -1` > src/auto_userl.c

src/auto_userl.o: \
compile src/auto_userl.c
	./compile src/auto_userl.c

src/auto_usero.c: \
auto-str conf-users
	./auto-str auto_usero `head -n 4 conf-users | tail -1` > src/auto_usero.c

src/auto_usero.o: \
compile src/auto_usero.c
	./compile src/auto_usero.c

src/auto_userp.c: \
auto-str conf-users
	./auto-str auto_userp `head -n 5 conf-users | tail -1` > src/auto_userp.c

src/auto_userp.o: \
compile src/auto_userp.c
	./compile src/auto_userp.c

src/auto_userq.c: \
auto-str conf-users
	./auto-str auto_userq `head -n 6 conf-users | tail -1` > src/auto_userq.c

src/auto_userq.o: \
compile src/auto_userq.c
	./compile src/auto_userq.c

src/auto_userr.c: \
auto-str conf-users
	./auto-str auto_userr `head -n 7 conf-users | tail -1` > src/auto_userr.c

src/auto_userr.o: \
compile src/auto_userr.c
	./compile src/auto_userr.c

src/auto_users.c: \
auto-str conf-users
	./auto-str auto_users `head -n 8 conf-users | tail -1` > src/auto_users.c

src/auto_users.o: \
compile src/auto_users.c
	./compile src/auto_users.c

src/auto_groupn.c: \
auto-str conf-groups
	./auto-str auto_groupn `head -n 2 conf-groups | tail -1` > src/auto_groupn.c

src/auto_groupn.o: \
compile src/auto_groupn.c
	./compile src/auto_groupn.c

src/auto_groupq.c: \
auto-str conf-groups
	./auto-str auto_groupq `head -n 1 conf-groups` > src/auto_groupq.c

src/auto_groupq.o: \
compile src/auto_groupq.c
	./compile src/auto_groupq.c

binm1: \
binm1.sh conf-qmail
	cat binm1.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> binm1
	chmod 755 binm1

binm1+df: \
binm1+df.sh conf-qmail
	cat binm1+df.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> binm1+df
	chmod 755 binm1+df

binm2: \
binm2.sh conf-qmail
	cat binm2.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> binm2
	chmod 755 binm2

binm2+df: \
binm2+df.sh conf-qmail
	cat binm2+df.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> binm2+df
	chmod 755 binm2+df

binm3: \
binm3.sh conf-qmail
	cat binm3.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> binm3
	chmod 755 binm3

binm3+df: \
binm3+df.sh conf-qmail
	cat binm3+df.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> binm3+df
	chmod 755 binm3+df

bouncesaying: \
load src/bouncesaying.o src/strerr.a src/error.a src/substdio.a src/str.a src/wait.a
	./load bouncesaying src/strerr.a src/error.a src/substdio.a src/str.a \
	src/wait.a 

doc/man/bouncesaying.0: \
doc/man/bouncesaying.1

src/bouncesaying.o: \
compile src/bouncesaying.c include/fork.h include/strerr.h include/error.h include/wait.h include/sig.h include/exit.h
	./compile src/bouncesaying.c

src/byte_chr.o: \
compile src/byte_chr.c include/byte.h
	./compile src/byte_chr.c

src/byte_copy.o: \
compile src/byte_copy.c include/byte.h
	./compile src/byte_copy.c

src/byte_cr.o: \
compile src/byte_cr.c include/byte.h
	./compile src/byte_cr.c

src/byte_rchr.o: \
compile src/byte_rchr.c include/byte.h
	./compile src/byte_rchr.c

src/byte_zero.o: \
compile src/byte_zero.c include/byte.h
	./compile src/byte_zero.c

src/case.a: \
makelib src/case_diffb.o src/case_diffs.o src/case_lowerb.o src/case_lowers.o \
src/case_starts.o
	./makelib src/case.a src/case_diffb.o src/case_diffs.o src/case_lowerb.o \
	src/case_lowers.o src/case_starts.o

src/case_diffb.o: \
compile src/case_diffb.c include/case.h
	./compile src/case_diffb.c

src/case_diffs.o: \
compile src/case_diffs.c include/case.h
	./compile src/case_diffs.c

src/case_lowerb.o: \
compile src/case_lowerb.c include/case.h
	./compile src/case_lowerb.c

src/case_lowers.o: \
compile src/case_lowers.c include/case.h
	./compile src/case_lowers.c

src/case_starts.o: \
compile src/case_starts.c include/case.h
	./compile src/case_starts.c

src/cdb.a: \
makelib src/cdb_hash.o src/cdb_unpack.o src/cdb_seek.o
	./makelib src/cdb.a src/cdb_hash.o src/cdb_unpack.o src/cdb_seek.o

src/cdb_hash.o: \
compile src/cdb_hash.c include/cdb.h include/uint32.h
	./compile src/cdb_hash.c

src/cdb_seek.o: \
compile src/cdb_seek.c include/cdb.h include/uint32.h
	./compile src/cdb_seek.c

src/cdb_unpack.o: \
compile src/cdb_unpack.c include/cdb.h include/uint32.h
	./compile src/cdb_unpack.c

src/cdbmake.a: \
makelib src/cdbmake_pack.o src/cdbmake_hash.o src/cdbmake_add.o
	./makelib src/cdbmake.a src/cdbmake_pack.o src/cdbmake_hash.o \
	src/cdbmake_add.o

src/cdbmake_add.o: \
compile src/cdbmake_add.c include/cdbmake.h include/alloc.h include/uint32.h
	./compile src/cdbmake_add.c

src/cdbmake_hash.o: \
compile src/cdbmake_hash.c include/cdbmake.h include/uint32.h
	./compile src/cdbmake_hash.c

src/cdbmake_pack.o: \
compile src/cdbmake_pack.c include/cdbmake.h include/uint32.h
	./compile src/cdbmake_pack.c

src/cdbmss.o: \
compile src/cdbmss.c include/readwrite.h include/seek.h include/alloc.h include/cdbmss.h include/cdbmake.h \
include/uint32.h include/substdio.h
	./compile src/cdbmss.c

check: \
it man
	./instcheck

chkspawn: \
load src/chkspawn.o src/substdio.a src/error.a src/str.a src/fs.a src/auto_spawn.o
	./load chkspawn src/substdio.a src/error.a src/str.a src/fs.a src/auto_spawn.o 

src/chkspawn.o: \
compile src/chkspawn.c include/substdio.h include/subfd.h include/substdio.h include/fmt.h include/select.h \
include/auto_spawn.h
	./compile src/chkspawn.c

clean: \
TARGETS
	rm -f `grep -v '^#' TARGETS`
	$(MAKE) -C tests clean

src/coe.o: \
compile src/coe.c include/coe.h
	./compile src/coe.c

src/commands.o: \
compile src/commands.c include/commands.h include/substdio.h include/stralloc.h include/gen_alloc.h include/str.h \
include/case.h
	./compile src/commands.c

compile: \
make-compile warn-auto.sh
	( cat warn-auto.sh; ./make-compile ) > compile
	chmod 755 compile

condredirect: \
load src/condredirect.o src/qmail.o src/strerr.a src/fd.a src/sig.a src/wait.a src/env.a \
src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o
	./load condredirect src/qmail.o src/strerr.a src/fd.a src/sig.a src/wait.a \
	src/env.a src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o

doc/man/condredirect.0: \
doc/man/condredirect.1

src/condredirect.o: \
compile src/condredirect.c include/sig.h include/readwrite.h include/exit.h include/env.h include/error.h include/fork.h \
include/wait.h include/seek.h include/qmail.h include/substdio.h include/strerr.h include/substdio.h include/fmt.h
	./compile src/condredirect.c

config: \
warn-auto.sh config.sh conf-qmail conf-break conf-split
	cat warn-auto.sh config.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPLIT}"`head -n 1 conf-split`"}g \
	> config
	chmod 755 config

config-fast: \
warn-auto.sh config-fast.sh conf-qmail conf-break conf-split
	cat warn-auto.sh config-fast.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPLIT}"`head -n 1 conf-split`"}g \
	> config-fast
	chmod 755 config-fast

src/constmap.o: \
compile src/constmap.c include/constmap.h include/alloc.h include/case.h
	./compile src/constmap.c

src/control.o: \
compile src/control.c include/readwrite.h include/open.h include/getln.h include/stralloc.h include/gen_alloc.h \
include/substdio.h include/error.h include/control.h include/alloc.h include/scan.h
	./compile src/control.c

src/date822fmt.o: \
compile src/date822fmt.c include/datetime.h include/fmt.h include/date822fmt.h
	./compile src/date822fmt.c

datemail: \
warn-auto.sh datemail.sh conf-qmail conf-break conf-split
	cat warn-auto.sh datemail.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPLIT}"`head -n 1 conf-split`"}g \
	> datemail
	chmod 755 datemail

src/datetime.a: \
makelib src/datetime.o src/datetime_un.o
	./makelib src/datetime.a src/datetime.o src/datetime_un.o

src/datetime.o: \
compile src/datetime.c include/datetime.h
	./compile src/datetime.c

src/datetime_un.o: \
compile src/datetime_un.c include/datetime.h
	./compile src/datetime_un.c

include/direntry.h: \
compile src/trydrent.c include/direntry.h1 include/direntry.h2
	( ./compile src/trydrent.c >/dev/null 2>&1 \
	&& cat include/direntry.h2 || cat include/direntry.h1 ) > include/direntry.h
	rm -f src/trydrent.o

dns.lib: \
src/tryrsolv.c compile load socket.lib src/dns.o src/ipalloc.o src/ip.o src/stralloc.a \
src/error.a src/fs.a src/str.a
	( ( ./compile src/tryrsolv.c && ./load tryrsolv src/dns.o \
	src/ipalloc.o src/ip.o src/stralloc.a src/error.a src/fs.a src/str.a \
	-lresolv `cat socket.lib` ) >/dev/null 2>&1 \
	&& echo -lresolv || exit 0 ) > dns.lib
	rm -f src/tryrsolv.o tryrsolv

src/dns.o: \
compile src/dns.c include/ip.h include/ipalloc.h include/ip.h include/gen_alloc.h include/fmt.h include/alloc.h include/str.h \
include/stralloc.h include/gen_alloc.h include/dns.h include/case.h
	./compile src/dns.c

src/dnsdoe.o: \
compile src/dnsdoe.c include/substdio.h include/subfd.h include/substdio.h include/exit.h include/dns.h include/dnsdoe.h
	./compile src/dnsdoe.c

dnsfq: \
load src/dnsfq.o src/dns.o src/dnsdoe.o src/ip.o src/ipalloc.o src/stralloc.a \
src/substdio.a src/error.a src/str.a src/fs.a dns.lib socket.lib
	./load dnsfq src/dns.o src/dnsdoe.o src/ip.o src/ipalloc.o src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a  `cat dns.lib` `cat socket.lib`

src/dnsfq.o: \
compile src/dnsfq.c include/substdio.h include/subfd.h include/substdio.h include/stralloc.h include/gen_alloc.h \
include/dns.h include/dnsdoe.h include/ip.h include/ipalloc.h include/ip.h include/gen_alloc.h
	./compile src/dnsfq.c

dnsip: \
load src/dnsip.o src/dns.o src/dnsdoe.o src/ip.o src/ipalloc.o src/stralloc.a \
src/substdio.a src/error.a src/str.a src/fs.a dns.lib socket.lib
	./load dnsip src/dns.o src/dnsdoe.o src/ip.o src/ipalloc.o src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a  `cat dns.lib` `cat socket.lib`

src/dnsip.o: \
compile src/dnsip.c include/substdio.h include/subfd.h include/substdio.h include/stralloc.h include/gen_alloc.h \
include/dns.h include/dnsdoe.h include/ip.h include/ipalloc.h include/ip.h include/gen_alloc.h
	./compile src/dnsip.c

dnsptr: \
load src/dnsptr.o src/dns.o src/dnsdoe.o src/ip.o src/ipalloc.o src/stralloc.a \
src/substdio.a src/error.a src/str.a src/fs.a dns.lib socket.lib
	./load dnsptr src/dns.o src/dnsdoe.o src/ip.o src/ipalloc.o src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a  `cat dns.lib` `cat socket.lib`

src/dnsptr.o: \
compile src/dnsptr.c include/substdio.h include/subfd.h include/substdio.h include/stralloc.h include/gen_alloc.h \
include/str.h include/scan.h include/dns.h include/dnsdoe.h include/ip.h
	./compile src/dnsptr.c

doc/man/dot-qmail.0: \
doc/man/dot-qmail.5

doc/man/dot-qmail.5: \
doc/man/dot-qmail.9 conf-qmail conf-break conf-spawn
	cat doc/man/dot-qmail.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/dot-qmail.5

src/env.a: \
makelib src/env.o src/envread.o
	./makelib src/env.a src/env.o src/envread.o

src/env.o: \
compile src/env.c include/str.h include/alloc.h include/env.h
	./compile src/env.c

doc/man/envelopes.0: \
doc/man/envelopes.5

src/envread.o: \
compile src/envread.c include/env.h include/str.h
	./compile src/envread.c

src/error.a: \
makelib src/error_str.o src/error_temp.o
	./makelib src/error.a src/error_str.o src/error_temp.o

src/error_str.o: \
compile src/error_str.c include/error.h
	./compile src/error_str.c

src/error_temp.o: \
compile src/error_temp.c include/error.h
	./compile src/error_temp.c

except: \
load src/except.o src/strerr.a src/error.a src/substdio.a src/str.a src/wait.a
	./load except src/strerr.a src/error.a src/substdio.a src/str.a src/wait.a 

doc/man/except.0: \
doc/man/except.1

src/except.o: \
compile src/except.c include/fork.h include/strerr.h include/wait.h include/error.h include/exit.h
	./compile src/except.c

src/fd.a: \
makelib src/fd_copy.o src/fd_move.o
	./makelib src/fd.a src/fd_copy.o src/fd_move.o

src/fd_copy.o: \
compile src/fd_copy.c include/fd.h
	./compile src/fd_copy.c

src/fd_move.o: \
compile src/fd_move.c include/fd.h
	./compile src/fd_move.c

src/fifo.o: \
compile src/fifo.c include/hasmkffo.h include/fifo.h
	./compile src/fifo.c

src/fmt_str.o: \
compile src/fmt_str.c include/fmt.h
	./compile src/fmt_str.c

src/fmt_strn.o: \
compile src/fmt_strn.c include/fmt.h
	./compile src/fmt_strn.c

src/fmt_uint.o: \
compile src/fmt_uint.c include/fmt.h
	./compile src/fmt_uint.c

src/fmt_uint0.o: \
compile src/fmt_uint0.c include/fmt.h
	./compile src/fmt_uint0.c

src/fmt_ulong.o: \
compile src/fmt_ulong.c include/fmt.h
	./compile src/fmt_ulong.c

src/fmtqfn.o: \
compile src/fmtqfn.c include/fmtqfn.h include/fmt.h include/auto_split.h
	./compile src/fmtqfn.c

doc/man/forgeries.0: \
doc/man/forgeries.7

forward: \
load src/forward.o src/qmail.o src/strerr.a src/fd.a src/wait.a src/sig.a src/env.a \
src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o
	./load forward src/qmail.o src/strerr.a src/fd.a src/wait.a src/sig.a \
	src/env.a src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o 

doc/man/forward.0: \
doc/man/forward.1

src/forward.o: \
compile src/forward.c include/sig.h include/readwrite.h include/env.h include/qmail.h include/substdio.h \
include/strerr.h include/substdio.h include/fmt.h
	./compile src/forward.c

src/fs.a: \
makelib src/fmt_str.o src/fmt_strn.o src/fmt_uint.o src/fmt_uint0.o src/fmt_ulong.o \
src/scan_ulong.o src/scan_8long.o
	./makelib src/fs.a src/fmt_str.o src/fmt_strn.o src/fmt_uint.o src/fmt_uint0.o \
	src/fmt_ulong.o src/scan_ulong.o src/scan_8long.o

src/getln.a: \
makelib src/getln.o src/getln2.o
	./makelib src/getln.a src/getln.o src/getln2.o

src/getln.o: \
compile src/getln.c include/substdio.h include/byte.h include/stralloc.h include/gen_alloc.h include/getln.h
	./compile src/getln.c

src/getln2.o: \
compile src/getln2.c include/substdio.h include/stralloc.h include/gen_alloc.h include/byte.h include/getln.h
	./compile src/getln2.c

src/getopt.a: \
makelib src/subgetopt.o src/sgetopt.o
	./makelib src/getopt.a src/subgetopt.o src/sgetopt.o

src/gfrom.o: \
compile src/gfrom.c include/str.h include/gfrom.h
	./compile src/gfrom.c

src/gid.o: \
compile src/gid.c include/uidgid.h include/subfd.h include/substdio.h include/exit.h
	./compile src/gid.c

include/hasflock.h: \
src/tryflock.c compile load
	( ( ./compile src/tryflock.c && ./load tryflock ) >/dev/null \
	2>&1 \
	&& echo \#define HASFLOCK 1 || exit 0 ) > include/hasflock.h
	rm -f src/tryflock.o tryflock

include/hasmkffo.h: \
src/trymkffo.c compile load
	( ( ./compile src/trymkffo.c && ./load trymkffo ) >/dev/null \
	2>&1 \
	&& echo \#define HASMKFIFO 1 || exit 0 ) > include/hasmkffo.h
	rm -f src/trymkffo.o trymkffo

include/hasnpbg1.h: \
src/trynpbg1.c compile load include/open.h src/open.a include/fifo.h src/fifo.o include/select.h
	( ( ./compile src/trynpbg1.c \
	&& ./load trynpbg1 src/fifo.o src/open.a && ./trynpbg1 ) \
	>/dev/null 2>&1 \
	&& echo \#define HASNAMEDPIPEBUG1 1 || exit 0 ) > \
	include/hasnpbg1.h
	rm -f src/trynpbg1.o trynpbg1

include/hassalen.h: \
src/trysalen.c compile
	( ./compile src/trysalen.c >/dev/null 2>&1 \
	&& echo \#define HASSALEN 1 || exit 0 ) > include/hassalen.h
	rm -f src/trysalen.o

include/hassgact.h: \
src/trysgact.c compile load
	( ( ./compile src/trysgact.c && ./load trysgact ) >/dev/null \
	2>&1 \
	&& echo \#define HASSIGACTION 1 || exit 0 ) > include/hassgact.h
	rm -f src/trysgact.o trysgact

include/hassgprm.h: \
src/trysgprm.c compile load
	( ( ./compile src/trysgprm.c && ./load trysgprm ) >/dev/null \
	2>&1 \
	&& echo \#define HASSIGPROCMASK 1 || exit 0 ) > include/hassgprm.h
	rm -f src/trysgprm.o trysgprm

include/haswaitp.h: \
src/trywaitp.c compile load
	( ( ./compile src/trywaitp.c && ./load trywaitp ) >/dev/null \
	2>&1 \
	&& echo \#define HASWAITPID 1 || exit 0 ) > include/haswaitp.h
	rm -f src/trywaitp.o trywaitp

src/headerbody.o: \
compile src/headerbody.c include/stralloc.h include/gen_alloc.h include/substdio.h include/getln.h \
include/hfield.h include/headerbody.h
	./compile src/headerbody.c

src/hfield.o: \
compile src/hfield.c include/hfield.h
	./compile src/hfield.c

src/hier.o: \
compile src/hier.c include/auto_qmail.h include/auto_split.h include/auto_uids.h include/fmt.h include/fifo.h include/hier.h
	./compile src/hier.c

home: \
home.sh conf-qmail
	cat home.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> home
	chmod 755 home

home+df: \
home+df.sh conf-qmail
	cat home+df.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> home+df
	chmod 755 home+df

hostname: \
load src/hostname.o src/substdio.a src/error.a src/str.a dns.lib socket.lib
	./load hostname src/substdio.a src/error.a src/str.a  `cat dns.lib` \
	`cat socket.lib`

src/hostname.o: \
compile src/hostname.c include/substdio.h include/subfd.h include/substdio.h include/readwrite.h
	./compile src/hostname.c

install: \
instpackage instchown warn-auto.sh
	( cat warn-auto.sh; echo './instpackage && ./instchown' ) > install
	chmod 755 install

instcheck: \
load src/instcheck.o src/instuidgid.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o \
src/ids.a src/strerr.a src/substdio.a src/error.a src/str.a src/fs.a
	./load instcheck src/instuidgid.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o \
	src/ids.a src/strerr.a src/substdio.a src/error.a src/str.a src/fs.a

src/instcheck.o: \
compile src/instcheck.c include/strerr.h include/error.h include/readwrite.h include/hier.h
	./compile src/instcheck.c

instchown: \
load src/instchown.o src/instuidgid.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o \
src/ids.a src/strerr.a src/substdio.a src/error.a src/str.a src/fs.a
	./load instchown src/instuidgid.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o \
	src/ids.a src/strerr.a src/substdio.a src/error.a src/str.a src/fs.a

src/instchown.o: \
compile src/instchown.c include/strerr.h include/error.h include/exit.h include/hier.h
	./compile src/instchown.c

src/instfiles.o: \
compile src/instfiles.c include/substdio.h include/strerr.h include/env.h include/error.h include/fifo.h include/open.h \
include/str.h include/stralloc.h
	./compile src/instfiles.c

instpackage: \
load src/instpackage.o src/instfiles.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o src/strerr.a \
src/substdio.a src/open.a src/error.a src/env.a src/str.a src/fs.a src/stralloc.a
	./load instpackage src/instfiles.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o \
	src/strerr.a src/substdio.a src/open.a src/error.a src/env.a src/str.a src/fs.a src/stralloc.a

src/instpackage.o: \
compile src/instpackage.c include/open.h include/strerr.h include/hier.h
	./compile src/instpackage.c

instqueue: \
load src/instqueue.o src/instfiles.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o src/strerr.a \
src/substdio.a src/open.a src/error.a src/env.a src/str.a src/fs.a src/stralloc.a
	./load instqueue src/instfiles.o src/fifo.o src/hier.o src/auto_qmail.o src/auto_split.o \
	src/strerr.a src/substdio.a src/open.a src/error.a src/env.a src/str.a src/fs.a src/stralloc.a

src/instqueue.o: \
compile src/instqueue.c include/open.h include/strerr.h include/hier.h
	./compile src/instqueue.c

src/instuidgid.o: \
compile src/instuidgid.c include/uidgid.h include/auto_uids.h include/auto_users.h
	./compile src/instuidgid.c

src/ip.o: \
compile src/ip.c include/fmt.h include/scan.h include/ip.h
	./compile src/ip.c

src/ipalloc.o: \
compile src/ipalloc.c include/alloc.h include/gen_allocdefs.h include/ip.h include/ipalloc.h include/ip.h \
include/gen_alloc.h include/oflops.h include/error.h
	./compile src/ipalloc.c

src/ipme.o: \
compile src/ipme.c include/hassalen.h include/byte.h include/ip.h include/ipalloc.h include/ip.h include/gen_alloc.h \
include/stralloc.h include/gen_alloc.h include/ipme.h include/ip.h include/ipalloc.h
	./compile src/ipme.c

ipmeprint: \
load src/ipmeprint.o src/ipme.o src/ip.o src/ipalloc.o src/stralloc.a src/substdio.a \
src/error.a src/str.a src/fs.a socket.lib
	./load ipmeprint src/ipme.o src/ip.o src/ipalloc.o src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a  `cat socket.lib`

src/ipmeprint.o: \
compile src/ipmeprint.c include/subfd.h include/substdio.h include/substdio.h include/ip.h include/ipme.h include/ip.h \
include/ipalloc.h include/ip.h include/gen_alloc.h
	./compile src/ipmeprint.c

it: \
qmail-local qmail-lspawn qmail-getpw qmail-remote qmail-rspawn \
qmail-clean qmail-send qmail-start splogger qmail-queue qmail-inject \
predate datemail mailsubj qmail-upq qmail-showctl qmail-newu \
qmail-pw2u qmail-qread qmail-qstat qmail-tcpto qmail-tcpok \
qmail-pop3d qmail-popup qmail-qmqpc qmail-qmqpd qmail-qmtpd \
qmail-smtpd sendmail tcp-env qmail-newmrh config config-fast \
dnsptr dnsip dnsfq hostname ipmeprint qreceipt qbiff \
forward preline condredirect bouncesaying except maildirmake \
maildir2mbox install instpackage instqueue instchown \
instcheck home home+df proc proc+df binm1 binm1+df binm2 binm2+df \
binm3 binm3+df

load: \
make-load warn-auto.sh
	( cat warn-auto.sh; ./make-load ) > load
	chmod 755 load

src/lock.a: \
makelib src/lock_ex.o src/lock_exnb.o src/lock_un.o
	./makelib src/lock.a src/lock_ex.o src/lock_exnb.o src/lock_un.o

src/lock_ex.o: \
compile src/lock_ex.c include/hasflock.h include/lock.h
	./compile src/lock_ex.c

src/lock_exnb.o: \
compile src/lock_exnb.c include/hasflock.h include/lock.h
	./compile src/lock_exnb.c

src/lock_un.o: \
compile src/lock_un.c include/hasflock.h include/lock.h
	./compile src/lock_un.c

doc/man/maildir.0: \
doc/man/maildir.5

src/maildir.o: \
compile src/maildir.c include/prioq.h include/datetime.h include/gen_alloc.h include/env.h include/stralloc.h \
include/gen_alloc.h include/direntry.h include/datetime.h include/now.h include/datetime.h include/str.h include/maildir.h \
include/strerr.h
	./compile src/maildir.c

maildir2mbox: \
load src/maildir2mbox.o src/maildir.o src/prioq.o src/myctime.o src/gfrom.o src/lock.a \
src/getln.a src/env.a src/open.a src/strerr.a src/stralloc.a src/substdio.a src/error.a \
src/str.a src/fs.a src/datetime.a
	./load maildir2mbox src/maildir.o src/prioq.o src/myctime.o \
	src/gfrom.o src/lock.a src/getln.a src/env.a src/open.a src/strerr.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a src/datetime.a

doc/man/maildir2mbox.0: \
doc/man/maildir2mbox.1

src/maildir2mbox.o: \
compile src/maildir2mbox.c include/readwrite.h include/prioq.h include/datetime.h include/gen_alloc.h \
include/env.h include/stralloc.h include/gen_alloc.h include/subfd.h include/substdio.h include/substdio.h include/getln.h \
include/error.h include/open.h include/lock.h include/gfrom.h include/str.h include/myctime.h include/maildir.h \
include/strerr.h
	./compile src/maildir2mbox.c

maildirmake: \
load src/maildirmake.o src/strerr.a src/substdio.a src/error.a src/str.a
	./load maildirmake src/strerr.a src/substdio.a src/error.a src/str.a 

doc/man/maildirmake.0: \
doc/man/maildirmake.1

src/maildirmake.o: \
compile src/maildirmake.c include/strerr.h
	./compile src/maildirmake.c

mailsubj: \
warn-auto.sh mailsubj.sh conf-qmail conf-break conf-split
	cat warn-auto.sh mailsubj.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPLIT}"`head -n 1 conf-split`"}g \
	> mailsubj
	chmod 755 mailsubj

doc/man/mailsubj.0: \
doc/man/mailsubj.1

make-compile: \
make-compile.sh auto-ccld.sh
	cat auto-ccld.sh make-compile.sh > make-compile
	chmod 755 make-compile

make-load: \
make-load.sh auto-ccld.sh
	cat auto-ccld.sh make-load.sh > make-load
	chmod 755 make-load

make-makelib: \
make-makelib.sh auto-ccld.sh
	cat auto-ccld.sh make-makelib.sh > make-makelib
	chmod 755 make-makelib

makelib: \
make-makelib warn-auto.sh
	( cat warn-auto.sh; ./make-makelib ) > \
	makelib
	chmod 755 makelib

man: \
doc/man/qmail-local.0 doc/man/qmail-lspawn.0 doc/man/qmail-getpw.0 doc/man/qmail-remote.0 \
doc/man/qmail-rspawn.0 doc/man/qmail-clean.0 doc/man/qmail-send.0 doc/man/qmail-start.0 doc/man/splogger.0 \
doc/man/qmail-queue.0 doc/man/qmail-inject.0 doc/man/mailsubj.0 doc/man/qmail-showctl.0 doc/man/qmail-newu.0 \
doc/man/qmail-pw2u.0 doc/man/qmail-qread.0 doc/man/qmail-qstat.0 doc/man/qmail-tcpto.0 doc/man/qmail-tcpok.0 \
doc/man/qmail-pop3d.0 doc/man/qmail-popup.0 doc/man/qmail-qmqpc.0 doc/man/qmail-qmqpd.0 doc/man/qmail-qmtpd.0 \
doc/man/qmail-smtpd.0 doc/man/tcp-env.0 doc/man/qmail-newmrh.0 doc/man/qreceipt.0 doc/man/qbiff.0 doc/man/forward.0 \
doc/man/preline.0 doc/man/condredirect.0 doc/man/bouncesaying.0 doc/man/except.0 doc/man/maildirmake.0 \
doc/man/maildir2mbox.0 doc/man/qmail.0 doc/man/qmail-limits.0 doc/man/qmail-log.0 \
doc/man/qmail-control.0 doc/man/qmail-header.0 doc/man/qmail-users.0 doc/man/dot-qmail.0 \
doc/man/qmail-command.0 doc/man/tcp-environ.0 doc/man/maildir.0 doc/man/mbox.0 doc/man/addresses.0 \
doc/man/envelopes.0 doc/man/forgeries.0

doc/man/mbox.0: \
doc/man/mbox.5

src/myctime.o: \
compile src/myctime.c include/datetime.h include/fmt.h include/myctime.h
	./compile src/myctime.c

src/ndelay.a: \
makelib src/ndelay.o src/ndelay_off.o
	./makelib src/ndelay.a src/ndelay.o src/ndelay_off.o

src/ndelay.o: \
compile src/ndelay.c include/ndelay.h
	./compile src/ndelay.c

src/ndelay_off.o: \
compile src/ndelay_off.c include/ndelay.h
	./compile src/ndelay_off.c

src/newfield.o: \
compile src/newfield.c include/fmt.h include/datetime.h include/stralloc.h include/gen_alloc.h \
include/date822fmt.h include/newfield.h include/stralloc.h
	./compile src/newfield.c

include/oflops.h: \
src/chkbiofl.c compile load include/oflops_bi.h include/oflops_compat.h
	 ( ( ./compile src/chkbiofl.c  && ./load chkbiofl && \
	./chkbiofl ) >/dev/null 2>&1 \
	&& cat include/oflops_bi.h || cat include/oflops_compat.h ) > include/oflops.h
	rm -f src/chkbiofl.o chkbiofl

src/open.a: \
makelib src/open_append.o src/open_excl.o src/open_read.o src/open_trunc.o \
src/open_write.o
	./makelib src/open.a src/open_append.o src/open_excl.o src/open_read.o \
	src/open_trunc.o src/open_write.o

src/open_append.o: \
compile src/open_append.c include/open.h
	./compile src/open_append.c

src/open_excl.o: \
compile src/open_excl.c include/open.h
	./compile src/open_excl.c

src/open_read.o: \
compile src/open_read.c include/open.h
	./compile src/open_read.c

src/open_trunc.o: \
compile src/open_trunc.c include/open.h
	./compile src/open_trunc.c

src/open_write.o: \
compile src/open_write.c include/open.h
	./compile src/open_write.c

package: \
it man
	./instpackage

predate: \
load src/predate.o src/datetime.a src/strerr.a src/sig.a src/fd.a src/wait.a src/substdio.a \
src/error.a src/str.a src/fs.a
	./load predate src/datetime.a src/strerr.a src/sig.a src/fd.a src/wait.a \
	src/substdio.a src/error.a src/str.a src/fs.a 

src/predate.o: \
compile src/predate.c include/datetime.h include/fork.h include/wait.h include/fd.h include/fmt.h include/strerr.h \
include/substdio.h include/subfd.h include/substdio.h include/readwrite.h include/sig.h
	./compile src/predate.c

preline: \
load src/preline.o src/strerr.a src/fd.a src/wait.a src/sig.a src/env.a src/getopt.a src/substdio.a \
src/error.a src/str.a
	./load preline src/strerr.a src/fd.a src/wait.a src/sig.a src/env.a src/getopt.a \
	src/substdio.a src/error.a src/str.a 

doc/man/preline.0: \
doc/man/preline.1

src/preline.o: \
compile src/preline.c include/fd.h include/sgetopt.h include/subgetopt.h include/readwrite.h include/strerr.h \
include/substdio.h include/fork.h include/wait.h include/env.h include/sig.h include/error.h
	./compile src/preline.c

src/prioq.o: \
compile src/prioq.c include/alloc.h include/gen_allocdefs.h include/prioq.h include/datetime.h \
include/gen_alloc.h include/oflops.h include/error.h
	./compile src/prioq.c

proc: \
proc.sh conf-qmail
	cat proc.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> proc
	chmod 755 proc

proc+df: \
proc+df.sh conf-qmail
	cat proc+df.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	> proc+df
	chmod 755 proc+df

src/prot.o: \
compile src/prot.c include/prot.h
	./compile src/prot.c

qbiff: \
load src/qbiff.o src/headerbody.o src/hfield.o src/getln.a src/env.a src/open.a src/stralloc.a \
src/substdio.a src/error.a src/str.a
	./load qbiff src/headerbody.o src/hfield.o src/getln.a src/env.a src/open.a \
	src/stralloc.a src/substdio.a src/error.a src/str.a

doc/man/qbiff.0: \
doc/man/qbiff.1

src/qbiff.o: \
compile src/qbiff.c include/readwrite.h include/stralloc.h include/gen_alloc.h include/substdio.h include/subfd.h \
include/substdio.h include/open.h include/byte.h include/str.h include/headerbody.h include/hfield.h include/env.h include/exit.h include/qtmp.h
	./compile src/qbiff.c

qmail-clean: \
load src/qmail-clean.o src/fmtqfn.o src/getln.a src/sig.a src/stralloc.a \
src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o src/auto_split.o
	./load qmail-clean src/fmtqfn.o src/getln.a src/sig.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o \
	src/auto_split.o 

doc/man/qmail-clean.0: \
doc/man/qmail-clean.8

src/qmail-clean.o: \
compile src/qmail-clean.c include/readwrite.h include/sig.h include/now.h include/datetime.h include/str.h \
include/direntry.h include/getln.h include/stralloc.h include/gen_alloc.h include/substdio.h include/subfd.h \
include/substdio.h include/byte.h include/scan.h include/fmt.h include/error.h include/exit.h include/fmtqfn.h include/auto_qmail.h
	./compile src/qmail-clean.c

doc/man/qmail-command.0: \
doc/man/qmail-command.8

doc/man/qmail-control.0: \
doc/man/qmail-control.5

doc/man/qmail-control.5: \
doc/man/qmail-control.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-control.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-control.5

qmail-getpw: \
load src/qmail-getpw.o src/case.a src/substdio.a src/error.a src/str.a src/fs.a src/auto_break.o \
src/ids.a
	./load qmail-getpw src/case.a src/substdio.a src/error.a src/str.a src/fs.a \
	src/auto_break.o src/ids.a

doc/man/qmail-getpw.0: \
doc/man/qmail-getpw.8

doc/man/qmail-getpw.8: \
doc/man/qmail-getpw.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-getpw.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-getpw.8

src/qmail-getpw.o: \
compile src/qmail-getpw.c include/readwrite.h include/substdio.h include/subfd.h include/substdio.h \
include/error.h include/exit.h include/byte.h include/str.h include/case.h include/fmt.h include/auto_users.h include/auto_break.h \
include/qlx.h
	./compile src/qmail-getpw.c

doc/man/qmail-header.0: \
doc/man/qmail-header.5

qmail-inject: \
load src/qmail-inject.o src/headerbody.o src/hfield.o src/newfield.o src/quote.o \
src/control.o src/date822fmt.o src/constmap.o src/qmail.o src/case.a src/fd.a src/wait.a src/open.a \
src/getln.a src/sig.a src/getopt.a src/datetime.a src/token822.o src/env.a src/stralloc.a \
src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o
	./load qmail-inject src/headerbody.o src/hfield.o src/newfield.o \
	src/quote.o src/control.o src/date822fmt.o src/constmap.o src/qmail.o \
	src/case.a src/fd.a src/wait.a src/open.a src/getln.a src/sig.a src/getopt.a src/datetime.a \
	src/token822.o src/env.a src/stralloc.a src/substdio.a src/error.a \
	src/str.a src/fs.a src/auto_qmail.o 

doc/man/qmail-inject.0: \
doc/man/qmail-inject.8

src/qmail-inject.o: \
compile src/qmail-inject.c include/sig.h include/substdio.h include/stralloc.h include/gen_alloc.h \
include/subfd.h include/substdio.h include/sgetopt.h include/subgetopt.h include/getln.h include/alloc.h include/str.h include/fmt.h \
include/hfield.h include/token822.h include/gen_alloc.h include/control.h include/env.h include/gen_alloc.h \
include/gen_allocdefs.h include/error.h include/qmail.h include/substdio.h include/now.h include/datetime.h include/error.h include/exit.h \
include/quote.h include/headerbody.h include/auto_qmail.h include/newfield.h include/stralloc.h include/constmap.h include/oflops.h
	./compile src/qmail-inject.c

doc/man/qmail-limits.0: \
doc/man/qmail-limits.7

doc/man/qmail-limits.7: \
doc/man/qmail-limits.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-limits.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-limits.7

qmail-local: \
load src/qmail-local.o src/qmail.o src/quote.o src/gfrom.o src/myctime.o \
src/slurpclose.o src/case.a src/getln.a src/getopt.a src/sig.a src/open.a src/lock.a src/fd.a \
src/wait.a src/env.a src/stralloc.a src/strerr.a src/substdio.a src/error.a src/str.a \
src/fs.a src/datetime.a src/auto_qmail.o src/auto_patrn.o socket.lib
	./load qmail-local src/qmail.o src/quote.o src/gfrom.o src/myctime.o \
	src/slurpclose.o src/case.a src/getln.a src/getopt.a src/sig.a src/open.a \
	src/lock.a src/fd.a src/wait.a src/env.a src/stralloc.a src/strerr.a \
	src/substdio.a src/error.a src/str.a src/fs.a src/datetime.a src/auto_qmail.o \
	src/auto_patrn.o  `cat socket.lib`

doc/man/qmail-local.0: \
doc/man/qmail-local.8

src/qmail-local.o: \
compile src/qmail-local.c include/readwrite.h include/sig.h include/env.h include/byte.h include/exit.h include/fork.h \
include/open.h include/wait.h include/lock.h include/seek.h include/substdio.h include/getln.h include/strerr.h include/subfd.h \
include/substdio.h include/sgetopt.h include/subgetopt.h include/alloc.h include/error.h include/stralloc.h \
include/gen_alloc.h include/fmt.h include/str.h include/now.h include/datetime.h include/case.h include/quote.h include/qmail.h \
include/substdio.h include/slurpclose.h include/myctime.h include/gfrom.h include/auto_patrn.h
	./compile src/qmail-local.c

doc/man/qmail-log.0: \
doc/man/qmail-log.5

qmail-lspawn: \
load src/qmail-lspawn.o src/spawn.o src/prot.o src/slurpclose.o src/coe.o src/sig.a src/wait.a \
src/case.a src/cdb.a src/fd.a src/open.a src/stralloc.a src/ids.a src/substdio.a src/error.a src/str.a \
src/fs.a src/auto_qmail.o src/auto_spawn.o
	./load qmail-lspawn src/spawn.o src/prot.o src/slurpclose.o src/coe.o src/sig.a src/wait.a \
	src/case.a src/cdb.a src/fd.a src/open.a src/stralloc.a src/auto_qmail.o \
	src/auto_spawn.o src/ids.a src/substdio.a src/error.a src/str.a src/fs.a

doc/man/qmail-lspawn.0: \
doc/man/qmail-lspawn.8

src/qmail-lspawn.o: \
compile src/qmail-lspawn.c include/fd.h include/wait.h include/prot.h include/substdio.h include/stralloc.h \
include/gen_alloc.h include/scan.h include/exit.h include/fork.h include/error.h include/cdb.h include/uint32.h include/case.h \
include/slurpclose.h include/uidgid.h include/auto_qmail.h include/auto_uids.h include/auto_users.h include/qlx.h include/byte.h \
include/open.h include/spawn.h
	./compile src/qmail-lspawn.c

qmail-newmrh: \
load src/qmail-newmrh.o src/cdbmss.o src/getln.a src/open.a src/cdbmake.a src/case.a \
src/stralloc.a src/strerr.a src/substdio.a src/error.a src/str.a src/auto_qmail.o
	./load qmail-newmrh src/cdbmss.o src/getln.a src/open.a src/cdbmake.a \
	src/case.a src/stralloc.a src/strerr.a src/substdio.a \
	src/error.a src/str.a src/auto_qmail.o 

doc/man/qmail-newmrh.0: \
doc/man/qmail-newmrh.8

doc/man/qmail-newmrh.8: \
doc/man/qmail-newmrh.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-newmrh.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-newmrh.8

src/qmail-newmrh.o: \
compile src/qmail-newmrh.c include/strerr.h include/stralloc.h include/gen_alloc.h include/substdio.h \
include/getln.h include/exit.h include/readwrite.h include/open.h include/auto_qmail.h include/cdbmss.h include/cdbmake.h \
include/uint32.h include/substdio.h include/case.h
	./compile src/qmail-newmrh.c

qmail-newu: \
load src/qmail-newu.o src/cdbmss.o src/getln.a src/open.a src/cdbmake.a src/case.a \
src/stralloc.a src/substdio.a src/error.a src/str.a src/auto_qmail.o
	./load qmail-newu src/cdbmss.o src/getln.a src/open.a src/cdbmake.a \
	src/case.a src/stralloc.a src/substdio.a src/error.a src/str.a \
	src/auto_qmail.o 

doc/man/qmail-newu.0: \
doc/man/qmail-newu.8

doc/man/qmail-newu.8: \
doc/man/qmail-newu.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-newu.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-newu.8

src/qmail-newu.o: \
compile src/qmail-newu.c include/stralloc.h include/gen_alloc.h include/subfd.h include/substdio.h \
include/getln.h include/substdio.h include/cdbmss.h include/cdbmake.h include/uint32.h include/substdio.h include/exit.h \
include/readwrite.h include/open.h include/error.h include/case.h include/auto_qmail.h include/byte.h
	./compile src/qmail-newu.c

qmail-pop3d: \
load src/qmail-pop3d.o src/commands.o src/case.a src/timeoutread.o src/timeoutwrite.o \
src/maildir.o src/prioq.o src/env.a src/strerr.a src/sig.a src/open.a src/getln.a \
src/stralloc.a src/substdio.a src/error.a src/str.a src/fs.a socket.lib
	./load qmail-pop3d src/commands.o src/case.a src/timeoutread.o \
	src/timeoutwrite.o src/maildir.o src/prioq.o src/env.a src/strerr.a src/sig.a \
	src/open.a src/getln.a src/stralloc.a src/substdio.a src/error.a src/str.a \
	src/fs.a  `cat socket.lib`

doc/man/qmail-pop3d.0: \
doc/man/qmail-pop3d.8

src/qmail-pop3d.o: \
compile src/qmail-pop3d.c include/commands.h include/sig.h include/getln.h include/stralloc.h include/gen_alloc.h \
include/substdio.h include/alloc.h include/open.h include/prioq.h include/datetime.h include/gen_alloc.h include/scan.h include/fmt.h \
include/str.h include/exit.h include/maildir.h include/strerr.h include/readwrite.h include/timeoutread.h \
include/timeoutwrite.h
	./compile src/qmail-pop3d.c

qmail-popup: \
load src/qmail-popup.o src/commands.o src/timeoutread.o src/timeoutwrite.o \
src/case.a src/fd.a src/sig.a src/wait.a src/stralloc.a src/substdio.a src/error.a src/str.a \
src/fs.a socket.lib
	./load qmail-popup src/commands.o src/timeoutread.o src/timeoutwrite.o \
	src/case.a src/fd.a src/sig.a src/wait.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a  `cat socket.lib`

doc/man/qmail-popup.0: \
doc/man/qmail-popup.8

src/qmail-popup.o: \
compile src/qmail-popup.c include/commands.h include/fd.h include/sig.h include/stralloc.h include/gen_alloc.h \
include/substdio.h include/alloc.h include/wait.h include/str.h include/byte.h include/now.h include/datetime.h include/fmt.h include/exit.h \
include/readwrite.h include/timeoutread.h include/timeoutwrite.h
	./compile src/qmail-popup.c

qmail-pw2u: \
load src/qmail-pw2u.o src/constmap.o src/control.o src/open.a src/getln.a src/case.a src/getopt.a \
src/stralloc.a src/substdio.a src/error.a src/str.a src/fs.a src/ids.a \
src/auto_break.o src/auto_qmail.o
	./load qmail-pw2u src/constmap.o src/control.o src/open.a src/getln.a \
	src/case.a src/getopt.a src/stralloc.a src/substdio.a src/error.a src/str.a \
	src/fs.a src/ids.a src/auto_break.o src/auto_qmail.o

doc/man/qmail-pw2u.0: \
doc/man/qmail-pw2u.8

doc/man/qmail-pw2u.8: \
doc/man/qmail-pw2u.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-pw2u.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-pw2u.8

src/qmail-pw2u.o: \
compile src/qmail-pw2u.c include/substdio.h include/readwrite.h include/subfd.h include/substdio.h \
include/sgetopt.h include/subgetopt.h include/control.h include/constmap.h include/stralloc.h include/gen_alloc.h \
include/fmt.h include/str.h include/scan.h include/open.h include/error.h include/getln.h include/exit.h include/auto_break.h include/auto_qmail.h \
include/auto_users.h include/byte.h
	./compile src/qmail-pw2u.c

qmail-qmqpc: \
load src/qmail-qmqpc.o src/slurpclose.o src/timeoutread.o src/timeoutwrite.o \
src/timeoutconn.o src/ip.o src/control.o src/auto_qmail.o src/sig.a src/ndelay.a src/open.a \
src/getln.a src/substdio.a src/stralloc.a src/error.a src/str.a src/fs.a socket.lib
	./load qmail-qmqpc src/slurpclose.o src/timeoutread.o \
	src/timeoutwrite.o src/timeoutconn.o src/ip.o src/control.o src/auto_qmail.o \
	src/sig.a src/ndelay.a src/open.a src/getln.a src/substdio.a src/stralloc.a \
	src/error.a src/str.a src/fs.a  `cat socket.lib`

doc/man/qmail-qmqpc.0: \
doc/man/qmail-qmqpc.8

src/qmail-qmqpc.o: \
compile src/qmail-qmqpc.c include/substdio.h include/getln.h include/readwrite.h include/exit.h \
include/stralloc.h include/gen_alloc.h include/slurpclose.h include/error.h include/sig.h include/ip.h include/timeoutconn.h \
include/timeoutread.h include/timeoutwrite.h include/auto_qmail.h include/control.h include/fmt.h
	./compile src/qmail-qmqpc.c

qmail-qmqpd: \
load src/qmail-qmqpd.o src/received.o src/date822fmt.o src/qmail.o src/auto_qmail.o \
src/env.a src/substdio.a src/sig.a src/error.a src/wait.a src/fd.a src/str.a src/datetime.a src/fs.a
	./load qmail-qmqpd src/received.o src/date822fmt.o src/qmail.o \
	src/auto_qmail.o src/env.a src/substdio.a src/sig.a src/error.a src/wait.a src/fd.a \
	src/str.a src/datetime.a src/fs.a 

doc/man/qmail-qmqpd.0: \
doc/man/qmail-qmqpd.8

src/qmail-qmqpd.o: \
compile src/qmail-qmqpd.c include/auto_qmail.h include/qmail.h include/substdio.h include/received.h include/str.h \
include/sig.h include/substdio.h include/readwrite.h include/exit.h include/now.h include/datetime.h include/fmt.h include/env.h include/byte.h
	./compile src/qmail-qmqpd.c

qmail-qmtpd: \
load src/qmail-qmtpd.o src/rcpthosts.o src/control.o src/constmap.o src/received.o \
src/date822fmt.o src/qmail.o src/cdb.a src/fd.a src/wait.a src/datetime.a src/open.a \
src/getln.a src/sig.a src/case.a src/env.a src/stralloc.a src/substdio.a src/error.a \
src/str.a src/fs.a src/auto_qmail.o
	./load qmail-qmtpd src/rcpthosts.o src/control.o src/constmap.o \
	src/received.o src/date822fmt.o src/qmail.o src/cdb.a src/fd.a src/wait.a \
	src/datetime.a src/open.a src/getln.a src/sig.a src/case.a src/env.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o

doc/man/qmail-qmtpd.0: \
doc/man/qmail-qmtpd.8

src/qmail-qmtpd.o: \
compile src/qmail-qmtpd.c include/stralloc.h include/gen_alloc.h include/substdio.h include/qmail.h \
include/substdio.h include/now.h include/datetime.h include/str.h include/fmt.h include/env.h include/sig.h include/rcpthosts.h \
include/auto_qmail.h include/readwrite.h include/control.h include/received.h include/exit.h
	./compile src/qmail-qmtpd.c

qmail-qread: \
load src/qmail-qread.o src/fmtqfn.o src/readsubdir.o src/date822fmt.o src/datetime.a \
src/open.a src/getln.a src/stralloc.a src/substdio.a src/error.a src/str.a src/fs.a \
src/auto_qmail.o src/auto_split.o
	./load qmail-qread src/fmtqfn.o src/readsubdir.o src/date822fmt.o \
	src/datetime.a src/open.a src/getln.a src/stralloc.a src/substdio.a \
	src/error.a src/str.a src/fs.a src/auto_qmail.o src/auto_split.o 

doc/man/qmail-qread.0: \
doc/man/qmail-qread.8

src/qmail-qread.o: \
compile src/qmail-qread.c include/stralloc.h include/gen_alloc.h include/substdio.h include/subfd.h \
include/substdio.h include/fmt.h include/str.h include/getln.h include/fmtqfn.h include/readsubdir.h include/direntry.h \
include/auto_qmail.h include/open.h include/datetime.h include/date822fmt.h include/readwrite.h include/error.h \
include/exit.h
	./compile src/qmail-qread.c

qmail-qstat: \
warn-auto.sh qmail-qstat.sh conf-qmail conf-break conf-split
	cat warn-auto.sh qmail-qstat.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPLIT}"`head -n 1 conf-split`"}g \
	> qmail-qstat
	chmod 755 qmail-qstat

doc/man/qmail-qstat.0: \
doc/man/qmail-qstat.8

qmail-queue: \
load src/qmail-queue.o src/triggerpull.o src/fmtqfn.o src/date822fmt.o \
src/datetime.a src/ndelay.a src/open.a src/sig.a src/substdio.a src/error.a \
src/str.a src/fs.a src/auto_qmail.o src/auto_split.o src/ids.a
	./load qmail-queue src/triggerpull.o src/fmtqfn.o \
	src/date822fmt.o src/datetime.a src/ndelay.a src/open.a src/sig.a \
	src/auto_qmail.o src/auto_split.o src/ids.a \
	src/substdio.a src/error.a src/str.a src/fs.a

doc/man/qmail-queue.0: \
doc/man/qmail-queue.8

src/qmail-queue.o: \
compile src/qmail-queue.c include/readwrite.h include/sig.h include/exit.h include/open.h include/seek.h include/fmt.h \
include/alloc.h include/substdio.h include/datetime.h include/now.h include/datetime.h include/triggerpull.h include/extra.h \
include/uidgid.h include/auto_qmail.h include/auto_uids.h include/auto_users.h include/date822fmt.h include/fmtqfn.h
	./compile src/qmail-queue.c

qmail-remote: \
load src/qmail-remote.o src/control.o src/constmap.o src/timeoutread.o src/timeoutwrite.o \
src/timeoutconn.o src/tcpto.o src/dns.o src/ip.o src/ipalloc.o src/ipme.o src/quote.o \
src/ndelay.a src/case.a src/sig.a src/open.a src/lock.a src/getln.a src/stralloc.a \
src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o dns.lib socket.lib
	./load qmail-remote src/control.o src/constmap.o src/timeoutread.o \
	src/timeoutwrite.o src/timeoutconn.o src/tcpto.o src/dns.o src/ip.o \
	src/ipalloc.o src/ipme.o src/quote.o src/ndelay.a src/case.a src/sig.a src/open.a \
	src/lock.a src/getln.a src/stralloc.a src/substdio.a src/error.a \
	src/str.a src/fs.a src/auto_qmail.o  `cat dns.lib` `cat socket.lib`

doc/man/qmail-remote.0: \
doc/man/qmail-remote.8

src/qmail-remote.o: \
compile src/qmail-remote.c include/sig.h include/stralloc.h include/gen_alloc.h include/substdio.h \
include/subfd.h include/substdio.h include/scan.h include/case.h include/error.h include/auto_qmail.h include/control.h include/dns.h \
include/alloc.h include/quote.h include/ip.h include/ipalloc.h include/ip.h include/gen_alloc.h include/ipme.h include/ip.h include/ipalloc.h \
include/gen_alloc.h include/gen_allocdefs.h include/str.h include/now.h include/datetime.h include/exit.h include/constmap.h \
include/tcpto.h include/readwrite.h include/timeoutconn.h include/timeoutread.h include/timeoutwrite.h include/oflops.h \
include/error.h
	./compile src/qmail-remote.c

qmail-rspawn: \
load src/qmail-rspawn.o src/spawn.o src/tcpto_clean.o src/coe.o src/sig.a src/open.a \
src/lock.a src/wait.a src/fd.a src/stralloc.a src/substdio.a src/error.a src/env.a src/str.a \
src/auto_qmail.o src/auto_spawn.o src/ids.a
	./load qmail-rspawn src/spawn.o src/tcpto_clean.o src/coe.o \
	src/sig.a src/open.a src/lock.a src/wait.a src/fd.a src/stralloc.a \
	src/auto_qmail.o src/ids.a src/substdio.a src/error.a src/env.a src/str.a \
	src/auto_spawn.o

doc/man/qmail-rspawn.0: \
doc/man/qmail-rspawn.8

src/qmail-rspawn.o: \
compile src/qmail-rspawn.c include/fd.h include/wait.h include/substdio.h include/exit.h include/fork.h include/error.h include/env.h \
include/tcpto.h include/spawn.h
	./compile src/qmail-rspawn.c

qmail-send: \
load src/qmail-send.o src/qsutil.o src/control.o src/constmap.o src/newfield.o src/prioq.o \
src/trigger.o src/fmtqfn.o src/quote.o src/readsubdir.o src/qmail.o src/date822fmt.o \
src/datetime.a src/case.a src/ndelay.a src/getln.a src/wait.a src/fd.a src/sig.a src/open.a \
src/lock.a src/stralloc.a src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o \
src/auto_split.o src/env.a
	./load qmail-send src/qsutil.o src/control.o src/constmap.o src/newfield.o \
	src/prioq.o src/trigger.o src/fmtqfn.o src/quote.o src/readsubdir.o \
	src/qmail.o src/date822fmt.o src/datetime.a src/case.a src/ndelay.a src/getln.a \
	src/wait.a src/fd.a src/sig.a src/open.a src/lock.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o src/auto_split.o src/env.a

doc/man/qmail-send.0: \
doc/man/qmail-send.8

doc/man/qmail-send.8: \
doc/man/qmail-send.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-send.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-send.8

src/qmail-send.o: \
compile src/qmail-send.c include/readwrite.h include/sig.h include/direntry.h include/control.h include/select.h \
include/open.h include/seek.h include/exit.h include/lock.h include/ndelay.h include/now.h include/datetime.h include/getln.h \
include/substdio.h include/alloc.h include/error.h include/stralloc.h include/gen_alloc.h include/str.h include/byte.h include/fmt.h \
include/scan.h include/case.h include/auto_qmail.h include/trigger.h include/newfield.h include/stralloc.h include/quote.h \
include/qmail.h include/substdio.h include/qsutil.h include/prioq.h include/datetime.h include/gen_alloc.h include/constmap.h \
include/fmtqfn.h include/readsubdir.h include/direntry.h
	./compile src/qmail-send.c

qmail-send.service: \
qmail-send.service.in conf-qmail
	cat qmail-send.service.in \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	> qmail-send.service

qmail-showctl: \
load src/qmail-showctl.o src/control.o src/open.a src/getln.a src/stralloc.a \
src/substdio.a src/error.a src/ids.a src/str.a src/fs.a src/auto_qmail.o src/auto_break.o src/auto_patrn.o \
src/auto_spawn.o src/auto_split.o
	./load qmail-showctl src/control.o src/open.a src/getln.a src/ids.a \
	src/stralloc.a src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o \
	src/auto_break.o src/auto_patrn.o src/auto_spawn.o src/auto_split.o

doc/man/qmail-showctl.0: \
doc/man/qmail-showctl.8

src/qmail-showctl.o: \
compile src/qmail-showctl.c include/substdio.h include/subfd.h include/substdio.h include/exit.h include/fmt.h \
include/str.h include/control.h include/constmap.h include/stralloc.h include/gen_alloc.h include/direntry.h include/uidgid.h \
include/auto_uids.h include/auto_users.h include/auto_qmail.h include/auto_break.h include/auto_patrn.h \
include/auto_spawn.h include/auto_split.h
	./compile src/qmail-showctl.c

qmail-smtpd: \
load src/qmail-smtpd.o src/rcpthosts.o src/commands.o src/timeoutread.o \
src/timeoutwrite.o src/ip.o src/ipme.o src/ipalloc.o src/control.o src/constmap.o src/received.o \
src/date822fmt.o src/qmail.o src/cdb.a src/fd.a src/wait.a src/datetime.a src/getln.a \
src/open.a src/sig.a src/case.a src/env.a src/stralloc.a src/substdio.a src/error.a src/str.a \
src/fs.a src/auto_qmail.o socket.lib
	./load qmail-smtpd src/rcpthosts.o src/commands.o src/timeoutread.o \
	src/timeoutwrite.o src/ip.o src/ipme.o src/ipalloc.o src/control.o src/constmap.o \
	src/received.o src/date822fmt.o src/qmail.o src/cdb.a src/fd.a src/wait.a \
	src/datetime.a src/getln.a src/open.a src/sig.a src/case.a src/env.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/fs.a src/auto_qmail.o  `cat \
	socket.lib`

doc/man/qmail-smtpd.0: \
doc/man/qmail-smtpd.8

src/qmail-smtpd.o: \
compile src/qmail-smtpd.c include/sig.h include/readwrite.h include/stralloc.h include/gen_alloc.h \
include/substdio.h include/alloc.h include/auto_qmail.h include/control.h include/received.h include/constmap.h \
include/error.h include/ipme.h include/ip.h include/ipalloc.h include/ip.h include/gen_alloc.h include/ip.h include/qmail.h \
include/substdio.h include/str.h include/fmt.h include/scan.h include/byte.h include/case.h include/env.h include/now.h include/datetime.h \
include/exit.h include/rcpthosts.h include/timeoutread.h include/timeoutwrite.h include/commands.h
	./compile src/qmail-smtpd.c

qmail-start: \
load src/qmail-start.o src/prot.o src/fd.a src/ids.a src/substdio.a src/error.a src/str.a
	./load qmail-start src/prot.o src/fd.a src/ids.a src/substdio.a src/error.a src/str.a

doc/man/qmail-start.0: \
doc/man/qmail-start.8

doc/man/qmail-start.8: \
doc/man/qmail-start.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-start.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-start.8

src/qmail-start.o: \
compile src/qmail-start.c include/fd.h include/prot.h include/exit.h include/fork.h include/uidgid.h include/auto_uids.h include/auto_users.h
	./compile src/qmail-start.c

qmail-tcpok: \
load src/qmail-tcpok.o src/open.a src/lock.a src/strerr.a src/substdio.a src/error.a src/str.a \
src/auto_qmail.o
	./load qmail-tcpok src/open.a src/lock.a src/strerr.a src/substdio.a \
	src/error.a src/str.a src/auto_qmail.o 

doc/man/qmail-tcpok.0: \
doc/man/qmail-tcpok.8

src/qmail-tcpok.o: \
compile src/qmail-tcpok.c include/strerr.h include/substdio.h include/lock.h include/open.h include/readwrite.h \
include/auto_qmail.h
	./compile src/qmail-tcpok.c

qmail-tcpto: \
load src/qmail-tcpto.o src/ip.o src/open.a src/lock.a src/substdio.a src/error.a src/str.a \
src/fs.a src/auto_qmail.o
	./load qmail-tcpto src/ip.o src/open.a src/lock.a src/substdio.a \
	src/error.a src/str.a src/fs.a src/auto_qmail.o 

doc/man/qmail-tcpto.0: \
doc/man/qmail-tcpto.8

src/qmail-tcpto.o: \
compile src/qmail-tcpto.c include/substdio.h include/subfd.h include/substdio.h include/auto_qmail.h include/byte.h \
include/fmt.h include/ip.h include/lock.h include/error.h include/exit.h include/datetime.h include/now.h include/datetime.h include/open.h
	./compile src/qmail-tcpto.c

qmail-upq: \
warn-auto.sh qmail-upq.sh conf-qmail conf-break conf-split
	cat warn-auto.sh qmail-upq.sh \
	| sed s}QMAIL}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPLIT}"`head -n 1 conf-split`"}g \
	> qmail-upq
	chmod 755 qmail-upq

doc/man/qmail-users.0: \
doc/man/qmail-users.5

doc/man/qmail-users.5: \
doc/man/qmail-users.9 conf-qmail conf-break conf-spawn
	cat doc/man/qmail-users.9 \
	| sed s}QMAILHOME}"`head -n 1 conf-qmail`"}g \
	| sed s}BREAK}"`head -n 1 conf-break`"}g \
	| sed s}SPAWN}"`head -n 1 conf-spawn`"}g \
	> doc/man/qmail-users.5

doc/man/qmail.0: \
doc/man/qmail.7

src/qmail.o: \
compile src/qmail.c include/substdio.h include/readwrite.h include/wait.h include/exit.h include/fork.h include/fd.h \
include/qmail.h include/auto_qmail.h include/env.h
	./compile src/qmail.c

qreceipt: \
load src/qreceipt.o src/headerbody.o src/hfield.o src/quote.o src/token822.o src/qmail.o \
src/getln.a src/fd.a src/wait.a src/sig.a src/env.a src/stralloc.a src/substdio.a src/error.a \
src/str.a src/auto_qmail.o
	./load qreceipt src/headerbody.o src/hfield.o src/quote.o src/token822.o \
	src/qmail.o src/getln.a src/fd.a src/wait.a src/sig.a src/env.a src/stralloc.a \
	src/substdio.a src/error.a src/str.a src/auto_qmail.o 

doc/man/qreceipt.0: \
doc/man/qreceipt.1

src/qreceipt.o: \
compile src/qreceipt.c include/sig.h include/env.h include/substdio.h include/stralloc.h include/gen_alloc.h \
include/subfd.h include/substdio.h include/getln.h include/alloc.h include/str.h include/hfield.h include/token822.h \
include/gen_alloc.h include/error.h include/gen_alloc.h include/gen_allocdefs.h include/headerbody.h include/exit.h \
include/open.h include/quote.h include/qmail.h include/substdio.h include/oflops.h include/error.h
	./compile src/qreceipt.c

src/qsutil.o: \
compile src/qsutil.c include/stralloc.h include/gen_alloc.h include/readwrite.h include/substdio.h \
include/qsutil.h
	./compile src/qsutil.c

include/qtmp.h: \
src/tryutmpx.c compile load include/qtmp.h1 include/qtmp.h2
	( ( ./compile src/tryutmpx.c && ./load tryutmpx ) >/dev/null 2>&1 \
	&& cat include/qtmp.h2 || cat include/qtmp.h1 ) > include/qtmp.h
	rm -f src/tryutmpx.o tryutmpx

src/quote.o: \
compile src/quote.c include/stralloc.h include/gen_alloc.h include/str.h include/quote.h include/oflops.h include/error.h
	./compile src/quote.c

src/rcpthosts.o: \
compile src/rcpthosts.c include/cdb.h include/uint32.h include/byte.h include/open.h include/error.h include/control.h \
include/constmap.h include/stralloc.h include/gen_alloc.h include/rcpthosts.h include/case.h
	./compile src/rcpthosts.c

src/readsubdir.o: \
compile src/readsubdir.c include/readsubdir.h include/direntry.h include/fmt.h include/scan.h include/str.h \
include/auto_split.h
	./compile src/readsubdir.c

src/received.o: \
compile src/received.c include/fmt.h include/qmail.h include/substdio.h include/now.h include/datetime.h \
include/datetime.h include/date822fmt.h include/received.h
	./compile src/received.c

src/remoteinfo.o: \
compile src/remoteinfo.c include/byte.h include/substdio.h include/ip.h include/fmt.h include/timeoutconn.h \
include/timeoutread.h include/timeoutwrite.h include/remoteinfo.h
	./compile src/remoteinfo.c

src/scan_8long.o: \
compile src/scan_8long.c include/scan.h
	./compile src/scan_8long.c

src/scan_ulong.o: \
compile src/scan_ulong.c include/scan.h
	./compile src/scan_ulong.c

include/select.h: \
compile src/trysysel.c include/select.h1 include/select.h2
	( ./compile src/trysysel.c >/dev/null 2>&1 \
	&& cat include/select.h2 || cat include/select.h1 ) > include/select.h
	rm -f src/trysysel.o trysysel

sendmail: \
load src/sendmail.o src/env.a src/getopt.a src/substdio.a src/error.a src/str.a \
src/auto_qmail.o
	./load sendmail src/env.a src/getopt.a src/substdio.a src/error.a \
	src/str.a src/auto_qmail.o 

src/sendmail.o: \
compile src/sendmail.c include/sgetopt.h include/subgetopt.h include/substdio.h include/subfd.h \
include/substdio.h include/alloc.h include/auto_qmail.h include/exit.h include/env.h include/str.h
	./compile src/sendmail.c

setup: \
it man
	./instpackage
	./instchown

src/sgetopt.o: \
compile src/sgetopt.c include/substdio.h include/subfd.h include/substdio.h include/sgetopt.h include/subgetopt.h \
include/subgetopt.h
	./compile src/sgetopt.c

src/sig.a: \
makelib src/sig_alarm.o src/sig_block.o src/sig_catch.o src/sig_pause.o src/sig_pipe.o \
src/sig_child.o src/sig_hup.o src/sig_term.o src/sig_bug.o src/sig_misc.o
	./makelib src/sig.a src/sig_alarm.o src/sig_block.o src/sig_catch.o \
	src/sig_pause.o src/sig_pipe.o src/sig_child.o src/sig_hup.o src/sig_term.o \
	src/sig_bug.o src/sig_misc.o

src/sig_alarm.o: \
compile src/sig_alarm.c include/sig.h
	./compile src/sig_alarm.c

src/sig_block.o: \
compile src/sig_block.c include/sig.h include/hassgprm.h
	./compile src/sig_block.c

src/sig_bug.o: \
compile src/sig_bug.c include/sig.h
	./compile src/sig_bug.c

src/sig_catch.o: \
compile src/sig_catch.c include/sig.h include/hassgact.h
	./compile src/sig_catch.c

src/sig_child.o: \
compile src/sig_child.c include/sig.h
	./compile src/sig_child.c

src/sig_hup.o: \
compile src/sig_hup.c include/sig.h
	./compile src/sig_hup.c

src/sig_misc.o: \
compile src/sig_misc.c include/sig.h
	./compile src/sig_misc.c

src/sig_pause.o: \
compile src/sig_pause.c include/sig.h include/hassgprm.h
	./compile src/sig_pause.c

src/sig_pipe.o: \
compile src/sig_pipe.c include/sig.h
	./compile src/sig_pipe.c

src/sig_term.o: \
compile src/sig_term.c include/sig.h
	./compile src/sig_term.c

src/slurpclose.o: \
compile src/slurpclose.c include/stralloc.h include/gen_alloc.h include/readwrite.h include/slurpclose.h \
include/error.h
	./compile src/slurpclose.c

socket.lib: \
src/trylsock.c compile load
	( ( ./compile src/trylsock.c && \
	./load trylsock -lsocket -lnsl ) >/dev/null 2>&1 \
	&& echo -lsocket -lnsl || exit 0 ) > socket.lib
	rm -f src/trylsock.o trylsock

src/spawn.o: \
compile chkspawn src/spawn.c include/sig.h include/wait.h include/substdio.h include/byte.h include/str.h \
include/stralloc.h include/gen_alloc.h include/select.h include/exit.h include/alloc.h include/coe.h include/open.h include/error.h \
include/auto_qmail.h include/auto_uids.h include/auto_spawn.h include/spawn.h
	./chkspawn
	./compile src/spawn.c

splogger: \
load src/splogger.o src/substdio.a src/error.a src/str.a src/fs.a syslog.lib socket.lib
	./load splogger src/substdio.a src/error.a src/str.a src/fs.a  `cat \
	syslog.lib` `cat socket.lib`

doc/man/splogger.0: \
doc/man/splogger.8

src/splogger.o: \
compile src/splogger.c include/error.h include/substdio.h include/subfd.h include/substdio.h include/exit.h include/str.h \
include/scan.h include/fmt.h
	./compile src/splogger.c

src/str.a: \
makelib src/str_chr.o \
src/str_rchr.o src/str_start.o src/byte_chr.o src/byte_rchr.o src/byte_copy.o \
src/byte_cr.o src/byte_zero.o
	./makelib src/str.a \
	src/str_chr.o src/str_rchr.o src/str_start.o src/byte_chr.o src/byte_rchr.o \
	src/byte_copy.o src/byte_cr.o src/byte_zero.o

src/str_chr.o: \
compile src/str_chr.c include/str.h
	./compile src/str_chr.c

src/str_rchr.o: \
compile src/str_rchr.c include/str.h
	./compile src/str_rchr.c

src/str_start.o: \
compile src/str_start.c include/str.h
	./compile src/str_start.c

src/stralloc.a: \
makelib src/stralloc_eady.o src/stralloc_pend.o src/stralloc_copy.o \
src/stralloc_opys.o src/stralloc_opyb.o src/stralloc_cat.o src/stralloc_cats.o \
src/stralloc_catb.o src/stralloc_arts.o
	./makelib src/stralloc.a src/stralloc_eady.o src/stralloc_pend.o \
	src/stralloc_copy.o src/stralloc_opys.o src/stralloc_opyb.o \
	src/stralloc_cat.o src/stralloc_cats.o src/stralloc_catb.o \
	src/stralloc_arts.o

src/stralloc_arts.o: \
compile src/stralloc_arts.c include/byte.h include/str.h include/stralloc.h include/gen_alloc.h
	./compile src/stralloc_arts.c

src/stralloc_cat.o: \
compile src/stralloc_cat.c include/byte.h include/stralloc.h include/gen_alloc.h
	./compile src/stralloc_cat.c

src/stralloc_catb.o: \
compile src/stralloc_catb.c include/stralloc.h include/gen_alloc.h include/byte.h include/error.h include/oflops.h
	./compile src/stralloc_catb.c

src/stralloc_cats.o: \
compile src/stralloc_cats.c include/byte.h include/str.h include/stralloc.h include/gen_alloc.h
	./compile src/stralloc_cats.c

src/stralloc_copy.o: \
compile src/stralloc_copy.c include/byte.h include/stralloc.h include/gen_alloc.h
	./compile src/stralloc_copy.c

src/stralloc_eady.o: \
compile src/stralloc_eady.c include/alloc.h include/stralloc.h include/gen_alloc.h \
include/gen_allocdefs.h include/oflops.h include/error.h
	./compile src/stralloc_eady.c

src/stralloc_opyb.o: \
compile src/stralloc_opyb.c include/stralloc.h include/gen_alloc.h include/byte.h include/error.h include/oflops.h
	./compile src/stralloc_opyb.c

src/stralloc_opys.o: \
compile src/stralloc_opys.c include/byte.h include/str.h include/stralloc.h include/gen_alloc.h
	./compile src/stralloc_opys.c

src/stralloc_pend.o: \
compile src/stralloc_pend.c include/alloc.h include/stralloc.h include/gen_alloc.h \
include/gen_allocdefs.h include/oflops.h include/error.h
	./compile src/stralloc_pend.c

src/strerr.a: \
makelib src/strerr_sys.o src/strerr_die.o
	./makelib src/strerr.a src/strerr_sys.o src/strerr_die.o

src/strerr_die.o: \
compile src/strerr_die.c include/substdio.h include/subfd.h include/substdio.h include/exit.h include/strerr.h
	./compile src/strerr_die.c

src/strerr_sys.o: \
compile src/strerr_sys.c include/error.h include/strerr.h
	./compile src/strerr_sys.c

src/subfderr.o: \
compile src/subfderr.c include/readwrite.h include/substdio.h include/subfd.h include/substdio.h
	./compile src/subfderr.c

src/subfdin.o: \
compile src/subfdin.c include/readwrite.h include/substdio.h include/subfd.h include/substdio.h
	./compile src/subfdin.c

src/subfdins.o: \
compile src/subfdins.c include/readwrite.h include/substdio.h include/subfd.h include/substdio.h
	./compile src/subfdins.c

src/subfdout.o: \
compile src/subfdout.c include/readwrite.h include/substdio.h include/subfd.h include/substdio.h
	./compile src/subfdout.c

src/subfdouts.o: \
compile src/subfdouts.c include/readwrite.h include/substdio.h include/subfd.h include/substdio.h
	./compile src/subfdouts.c

src/subgetopt.o: \
compile src/subgetopt.c include/subgetopt.h
	./compile src/subgetopt.c

src/substdi.o: \
compile src/substdi.c include/substdio.h include/byte.h include/error.h
	./compile src/substdi.c

src/substdio.a: \
makelib src/substdio.o src/substdi.o src/substdo.o src/subfderr.o src/subfdout.o \
src/subfdouts.o src/subfdin.o src/subfdins.o src/substdio_copy.o
	./makelib src/substdio.a src/substdio.o src/substdi.o src/substdo.o \
	src/subfderr.o src/subfdout.o src/subfdouts.o src/subfdin.o src/subfdins.o \
	src/substdio_copy.o

src/substdio.o: \
compile src/substdio.c include/substdio.h
	./compile src/substdio.c

src/substdio_copy.o: \
compile src/substdio_copy.c include/substdio.h
	./compile src/substdio_copy.c

src/substdo.o: \
compile src/substdo.c include/substdio.h include/str.h include/byte.h include/error.h
	./compile src/substdo.c

syslog.lib: \
src/trysyslog.c compile load
	( ( ./compile src/trysyslog.c && \
	./load trysyslog -lgen ) >/dev/null 2>&1 \
	&& echo -lgen || exit 0 ) > syslog.lib
	rm -f src/trysyslog.o trysyslog

tcp-env: \
load src/tcp-env.o src/dns.o src/remoteinfo.o src/timeoutread.o src/timeoutwrite.o \
src/timeoutconn.o src/ip.o src/ipalloc.o src/case.a src/ndelay.a src/sig.a src/env.a src/getopt.a \
src/stralloc.a src/substdio.a src/error.a src/str.a src/fs.a dns.lib socket.lib
	./load tcp-env src/dns.o src/remoteinfo.o src/timeoutread.o \
	src/timeoutwrite.o src/timeoutconn.o src/ip.o src/ipalloc.o src/case.a src/ndelay.a \
	src/sig.a src/env.a src/getopt.a src/stralloc.a src/substdio.a src/error.a \
	src/str.a src/fs.a  `cat dns.lib` `cat socket.lib`

doc/man/tcp-env.0: \
doc/man/tcp-env.1

src/tcp-env.o: \
compile src/tcp-env.c include/sig.h include/stralloc.h include/gen_alloc.h include/str.h include/env.h include/fmt.h \
include/scan.h include/subgetopt.h include/ip.h include/dns.h include/byte.h include/remoteinfo.h include/exit.h include/case.h
	./compile src/tcp-env.c

doc/man/tcp-environ.0: \
doc/man/tcp-environ.5

src/tcpto.o: \
compile src/tcpto.c include/tcpto.h include/open.h include/lock.h include/seek.h include/now.h include/datetime.h include/ip.h \
include/byte.h include/datetime.h include/readwrite.h
	./compile src/tcpto.c

src/tcpto_clean.o: \
compile src/tcpto_clean.c include/tcpto.h include/open.h include/substdio.h include/readwrite.h
	./compile src/tcpto_clean.c

test: it
	@$(MAKE) -C tests test

src/timeoutconn.o: \
compile src/timeoutconn.c include/ndelay.h include/select.h include/error.h include/readwrite.h include/ip.h \
include/byte.h include/timeoutconn.h
	./compile src/timeoutconn.c

src/timeoutread.o: \
compile src/timeoutread.c include/timeoutread.h include/select.h include/error.h include/readwrite.h
	./compile src/timeoutread.c

src/timeoutwrite.o: \
compile src/timeoutwrite.c include/timeoutwrite.h include/select.h include/error.h include/readwrite.h
	./compile src/timeoutwrite.c

src/token822.o: \
compile src/token822.c include/stralloc.h include/gen_alloc.h include/alloc.h include/str.h include/token822.h \
include/gen_alloc.h include/gen_allocdefs.h include/oflops.h include/error.h
	./compile src/token822.c

src/trigger.o: \
compile src/trigger.c include/select.h include/open.h include/trigger.h include/hasnpbg1.h
	./compile src/trigger.c

src/triggerpull.o: \
compile src/triggerpull.c include/ndelay.h include/open.h include/triggerpull.h
	./compile src/triggerpull.c

src/uid.o: \
compile src/uid.c include/uidgid.h include/subfd.h include/substdio.h include/exit.h
	./compile src/uid.c

src/ids.a: \
makelib src/auto_usera.o src/auto_userd.o src/auto_userl.o src/auto_usero.o src/auto_userp.o \
src/auto_userq.o src/auto_userr.o src/auto_users.o src/auto_groupn.o src/auto_groupq.o src/gid.o src/uid.o
	./makelib src/ids.a src/auto_usera.o src/auto_userd.o src/auto_userl.o src/auto_usero.o \
	src/auto_userp.o src/auto_userq.o src/auto_userr.o src/auto_users.o src/auto_groupn.o \
	src/auto_groupq.o src/gid.o src/uid.o

src/wait.a: \
makelib src/wait_pid.o src/wait_nohang.o
	./makelib src/wait.a src/wait_pid.o src/wait_nohang.o

src/wait_nohang.o: \
compile src/wait_nohang.c include/haswaitp.h
	./compile src/wait_nohang.c

src/wait_pid.o: \
compile src/wait_pid.c include/error.h include/haswaitp.h
	./compile src/wait_pid.c
