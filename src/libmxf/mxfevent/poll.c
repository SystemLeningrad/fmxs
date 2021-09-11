/*
 * libmxf/mxfevent/poll.c - poll support for the mxfevent interface
 * Copyright (C)     -2021 Ellenor Bjornsdottir
 * All rights reserved.
 *
 * Permission to use, modify, redistribute, or incorporate this work
 * is granted, provided that the terms in doc/LICENCE are followed.
 */

#include <mxfevent/event.h>

// This is safe because this file will only be compiled on platforms
// that support poll.h.
#include <poll.h>

// MUST NOT BE NULL PTR! can be 0 refs tho.
int mxfpoll (
	rc_ptr_t *mxfpollqueue, pollfd_t fds[], nfds_t nfds,
	mxftimespec_t *timeout
) {
	unsigned int *refc, *queue;
	int ret = 0;
	refc = &((*mxfpollqueue).refs);
	mxfpq_t *mxfpq = (mxfpq_t *)(mxfpollqueue->opaque);
	queue = &(mxfpq->queue); // Not actually used in the poll() variant
	*refc++; // now 1 ref

	if (*refc > 0) return -2; // This queue is already in use.

#ifdef USING_PPOLL
	ret = ppoll((struct pollfd *)fds, nfds, timeout, 0);
#else
	ret = poll((struct pollfd *)fds, nfds, (timeout == NULL) ? 0 : ((timeout->tv_sec * 1000)+((timeout->tv_nsec) / 1000 / 1000)));
#endif
	*refc--; // back to 0 ref
	return ret;
}
