/*
 * libmxf/mxfevent/bsdq.c - kqueue support for the mxfevent interface
 * Copyright (C)     -2021 Ellenor Bjornsdottir
 * All rights reserved.
 *
 * Permission to use, modify, redistribute, or incorporate this work
 * is granted, provided that the terms in doc/LICENCE are followed.
 */

#include <mxfevent/event.h>

// This is safe because this file will not be compiled except on BSD.
#include <sys/event.h>

