#!/usr/bin/env python3

import iterm2
import sys

async def find_test_tab(window):
    for tab in window.tabs:
        tab_name = await tab.async_get_variable("title")
        if tab_name == "Tests":
            return tab

async def main(connection):
    test_command = sys.argv[1]

    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window

    test_tab = await find_test_tab(window)
    if test_tab is not None:
        session = test_tab.sessions[0]
        await session.async_send_text(test_command + '\n')
        await test_tab.async_activate(order_window_front=True)
    else:
        print("could not find test tab")


iterm2.run_until_complete(main)
