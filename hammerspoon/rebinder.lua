-- rebinder.lua
-- Functionality for rebinding hotkeys on a per-app basis


-- local finder = hs.appfinder.appFromName("Finder")
-- finder:selectMenuItem():

createNewFolder
-- "New Folder"

openNewFinderWindow = hs.hotkey.new('⌘', 'r', function()
  -- "New Finder Window"
  -- hs.application.launchOrFocus("Firefox.app")
  -- reloadFxFromRubyMine:disable() -- does not work without this, even though it should
  -- hs.eventtap.keyStroke({"⌘"}, "r")
end)

-- hs.window.filter.new('RubyMine')
--     :subscribe(hs.window.filter.windowFocused,function() reloadFxFromRubyMine:enable() end)
--     :subscribe(hs.window.filter.windowUnfocused,function() reloadFxFromRubyMine:disable() end)
