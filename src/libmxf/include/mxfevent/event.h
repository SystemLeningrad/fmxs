/*
 * libmxf/include/mxfevent/event.h - header for programs relying on mxfevent
 * Copyright (C) 2021 Ellenor Bjornsdottir
 * All rights reserved.
 *
 * Permission to use, modify, redistribute, or incorporate this work
 * is granted, provided that the terms in doc/LICENCE are followed.
 */

#ifndef HAS_MXFEVENT_EVENT_H
#define HAS_MXFEVENT_EVENT_H
#include <stddef.h>

#ifndef SYS_POLL_H
#define	BMFLAG(n)		(1<<(n-1))
// only these events/filters are meaningful to us in mxfevent
#define EVENTREAD		BMFLAG(1)
#define EVENTWRITE		BMFLAG(2)
#define	EVENTERR		BMFLAG(3)
#define	EVENTHUP		BMFLAG(4)
#define	EVENTNVAL		BMFLAG(5)
#else
#define	EVENTREAD		POLLIN|POLLRDNORM
#define	EVENTWRITE		POLLOUT|POLLWRNORM
#define	EVENTERR		POLLERR
#define	EVENTHUP		POLLHUP
#define	EVENTNVAL		POLLNVAL
#endif
typedef struct {
	unsigned int	refs; // References
	void			*opaque; // pointer to user's opaque
} rc_ptr_t; // XXX: will we ever use this?

typedef struct {
	unsigned int	queue; // kq fd; only used by kq, epoll and illumos ports
} mxfpq_t; // this is an opaque that'll be used in rc_ptr_t by mxfpoll

// mxfpoll() will be conceptually similar to a bastard hybrid
// of kqueue() and ppoll and will be implemented using
// the former or the latter in order if available.
typedef int event_return_t;

#ifndef SYS_POLL_H
typedef struct {
	int		fd; // File descriptor, as in struct pollfd
	short	events; // Events user seeks
	short	revents; // Events user got
} pollfd_t; // low level structure
typedef	unsigned int	nfds_t;
#else
typedef	struct pollfd	pollfd_t;
#endif

// temporary until we import TAI handling
typedef	struct timespec mxftimespec_t;

extern	int mxfpoll (rc_ptr_t *mxfpollqueue, pollfd_t fds[], nfds_t nfds, mxftimespec_t *timeout);

#endif
