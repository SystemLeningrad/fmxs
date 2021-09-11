/*
 * include/mxf/pronouns.h - replacements for mentions of "he," "him," and "his" in the MXF code
 * This file is part of MXF. See doc/LICENCE.mxf.
Copyright 2021 Ellenor et al Bjornsdottir, and the MXF Contributors. All Rights Reserved.
Copyright 1997 disclaimed in 2007 by Professor Daniel Bernstein.

Your licence to this software is governed under the laws of BC, Canada, except as required by applicable laws where you may reside.

This is software, and it is NOT Open Source software,
per https://opensource.org/faq#avoid-unapproved-licenses .

The source is available to you and your assigns provided that you and they follow the terms in doc/LICENCE.mxf. If they are onerous, speak to the Initial Developer(s) and the Contributor(s) and/or their heirs or assigns, and you may be able to obtain special dispensation to use and redistribute the software under other licence terms.

You should have received a copy of the Umbrellix Softare Licence, or other special licence you may have negotiated, with this programme.
 */

/*
 * Dan Bernstein is from a time and culture where
 * the singular epicene pronoun was 'he'.
 *
 * In MXF, we offer the ability but not the requirement
 * to change this to any pronouns you like at compile time.
 * We default to singular they, but allow reversion to he
 * via C preprocessor command line options. You may also
 * opt to use ey, co, thon, or xe.
 */

#ifndef _WITH_PRONOUNS_H
#define _WITH_PRONOUNS_H

#ifndef PRONOUN_THEY
#define PRONOUN_THEY "they"
#endif

#ifndef PRONOUN_THEM
#define PRONOUN_THEM "them"
#endif

#ifndef PRONOUN_THEIR
#define PRONOUN_THEIR "their"
#endif

#ifndef PRONOUN_THEIRS
#define PRONOUN_THEIRS "theirs"
#endif

#ifndef PRONOUN_IS_SINGULAR
#define PRONOUN_IS_PLURAL
#endif

#endif
