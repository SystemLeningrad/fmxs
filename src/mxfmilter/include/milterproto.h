/* src/mxfmilter/include/milterproto.h
 * Milter protocol definitions.
 * This file was created with reference to publicly available documentation
 at http://www.pell.portland.or.us/~orc/Code/postoffice/milter-protocol.html .
 *
 * Copyright 2021 Ellenor Bjornsdottir ellenor@umbrellix.net
 * All Rights Reserved.
 * Unlike the rest of the MXF distribution,
 * Permission to use, redistribute, evaluate, or modify this work is granted
 provided the above copyright notice, this permission notice, and the
 following warranty notice are retained.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 THE POSSIBILITY OF SUCH DAMAGE.
 *
 * As a special exception, the warranty notice above may be reproduced in
 regular sentence case to ease readability.
 */

#ifndef _WITH_MXFMILTER_MILTERPROTO_H
#define _WITH_MXFMILTER_MILTERPROTO_H

/* Yes, I'm really writing my own Milter protocol library. Why?
   None are license compatible with the USL, under which MXF is
   released. The final product of this project will be a
   "miltersleeve" for mxf-local, mxf-remote and mxf-qmtpc,
   written in C and released under the USL, using this library. */

// From-MTA

#define MTA_ABORT		'A'
#define MTA_BODYCHUNK	'B'
#define MTA_CLIENT		'C'
#define MTA_SMMACROS	'D' // {CMHR}nameNULvalueNULnameNULvalueNUL
#define MTA_ENDBODY		'E'
#define MTA_HELO		'H'
#define MTA_HEADER		'L' // nameNULvalueNUL
#define MTA_ENDHDR		'N'
#define MTA_MAILFROM	'M' // senderNULesmtparg...NUL
#define MTA_RCPTTO		'R' // recipientNULesmtparg...NUL
#define MTA_OPTNEG		'O' // uint32s: version, actions, protocol
#define MTA_QUIT		'Q'

// From Filter

#define FILTER_ADDRCPT	'+' // rcptNUL
#define FILTER_DELRCPT	'-' // rcptNUL
#define FILTER_ACCEPT	'a'
#define FILTER_TACCEPT	'c'
#define FILTER_REPBODY	'b' // body
#define FILTER_DISCARD	'd'
#define FILTER_ADDHDR	'h' // nameNULvalueNUL
#define FILTER_CHGHDR	'm' // unti32 idx, nameNULvalueNUL
#define FILTER_PROGRESS	'p' // still making progress
#define FILTER_40INE	'q' // reasonNUL
#define FILTER_FAILD	'r' // D-type failure
#define FILTER_FAILZ	't' // Z-type failure
#define FILTER_FREPLY	'y' // smtpcode[3] textNUL
#define FILTER_OPTNEG	MTA_OPTNEG

// Actions

#define ACTION_	0x01
#define ACTION_	0x02
#define ACTION_	0x04
#define ACTION_	0x08
#define ACTION_	0x10
#define ACTION_	0x20

// Skips

#define SKIP_CONNECT	0x01
#define SKIP_HELO		0x02
#define SKIP_MAILFROM	0x04
#define SKIP_RCPTTO		0x08
#define SKIP_BODY		0x10
#define SKIP_HEADER		0x20
#define SKIP_ENDHDR		0x40

// Structure

typedef struct {
	uint32_t	length; // subtract 1 for the length of the str pointed to in data
	char		cmd;
	void		*data; // treat as chars in practice
} miltercommand;

#endif
