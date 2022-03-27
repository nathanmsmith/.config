#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import iterm2
import AppKit

# Launch iTerm
bundle = "com.googlecode.iterm2"
if not AppKit.NSRunningApplication.runningApplicationsWithBundleIdentifier_(bundle):
    AppKit.NSWorkspace.sharedWorkspace().launchApplication_("iTerm")

dir = '~/Developer/Hotseat/hotseat.io'

tab_names = [
    'Editor',
    'Server',
    'Shell',
    'Tests'
]
tab_commands = [
    '/opt/homebrew/bin/fish -l -c nvim',
    None,
    None,
    None
]

async def main(connection):
    app = await iterm2.async_get_app(connection)

    # Foreground the app
    await app.async_activate()

    window = await iterm2.Window.async_create(connection)
    extra_tab = window.current_tab

    for tab_name, tab_command in zip(tab_names, tab_commands):
        profile = iterm2.LocalWriteOnlyProfile()
        profile.set_initial_directory_mode(iterm2.InitialWorkingDirectory.INITIAL_WORKING_DIRECTORY_CUSTOM)
        profile.set_custom_directory(dir)
        if tab_command is not None:
            profile.set_use_custom_command('Yes')
            profile.set_command(tab_command)
        tab = await window.async_create_tab(profile_customizations=profile)
        await tab.async_set_title(tab_name)

    await extra_tab.async_close(force=True)


iterm2.run_until_complete(main, True)
