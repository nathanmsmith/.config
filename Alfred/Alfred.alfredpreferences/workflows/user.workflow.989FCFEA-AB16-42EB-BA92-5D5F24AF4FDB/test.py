#!/usr/bin/env python
from __future__ import unicode_literals
from cgi import escape
from uuid import uuid4
import os
import sys


PATH, _ = os.path.split(os.getcwd())

def search_symbols(query_text, symbols=None):
    if not symbols:
        symbols = load_symbols()
    query = create_query(query_text)
    for symbol in symbols:
        if query(symbol):
            yield symbol


def create_query(query_text):
    query_words = query_text.split(' ')
    letters = [l for l in query_words if len(l) == 1]
    if len(letters) == 1:
        return create_single_letter_query(letters[0], query_words)
    return create_words_query(query_words)


def create_single_letter_query(letter, query_words):
    words_query = create_words_query(query_words)
    prefix = letter + ' '
    sufix = ' ' + letter
    infix = ' ' + letter + ' '

    def is_letter_in_symbol(symbol):
        symbol_itself, description = symbol
        return (
            symbol_itself == query_text or
            description.startswith(prefix) or
            description.endswith(sufix) or
            infix in description
        ) and words_query(symbol)
    return is_letter_in_symbol


def create_words_query(query_words):
    def is_symbol_matching(symbol):
        symbol_itself, description = symbol
        description_matches = all(word in description for word in query_words)
        return description_matches
    return is_symbol_matching


def load_symbols(path=None):
    if not path:
        path = get_symbols_path()
    return [parse_symbol(l) for l in read6(path).splitlines()]


def parse_symbol(line):
    split = line.split('| ')
    return split[0].strip(), split[1]


def get_symbols_path():
    return os.path.join(PATH, 'symbols.txt')


def read6(path):
    try:
        with open(path, encoding='utf-8') as f:
            return f.read()
    except:
        with open(path) as f:
            return f.read().decode('utf-8')


class AlfredItemsList(object):
    def __init__(self, items=None):
        self.items = items or []
        self.pattern = (
            '<item arg="{arg}" uid="{uid}" valid="{valid}">"' +
                '<title>{title}</title>' +
                '<subtitle>{subtitle}</subtitle>' +
                '<icon>no-icon</icon>'
            '</item>'
        )

    def append(
        self, arg, title, subtitle,
        valid='yes', uid=None
    ):
        """
        Add item to list,
        pass uid = None to preserve order in list when it's displayed in Alfred.

        There is no other way to prevent alfred from reordering
        items than to ensure that uid never repeats.
        """
        uid = uid or str(uuid4())
        self.items.append(
            (arg, escape(title), escape(subtitle), valid, uid)
        )

    def __str__(self):
        items = "".join([
            self.pattern.format(
                arg=arg,
                title=escape(title),
                subtitle=escape(subtitle),
                valid=valid,
                uid=uid
            ) for arg, title, subtitle, valid, uid in self.items
        ])
        return ('<items>' + items + '</items>').encode('utf-8')

    def __add__(self, other):
        return AlfredItemsList(self.items + other.items)



query_text = ''.join(sys.argv[1:])
al = AlfredItemsList()
for symbol, description in search_symbols(query_text):
    codepoints = symbol.encode(
        "unicode_escape"
    ).decode('utf-8').replace('\\u', ' ').replace('\\U', ' ').strip()
    al.append(symbol, symbol, codepoints + ' | ' + description, uid=symbol)

print(al)

