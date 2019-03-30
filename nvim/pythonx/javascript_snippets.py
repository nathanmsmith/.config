#!/usr/bin/env python
"""
Helper utilities to format javascript snippets.
"""

ALWAYS = "always"
NEVER = "never"


def get_option(snip, option, default=None):
    return snip.opt('g:ultisnips_javascript["{}"]'.format(option), default)


def semi(snip):
    option = get_option(snip, "semi", ALWAYS)

    if option == NEVER:
        ret = ""
    else:
        ret = ";"
    return ret
