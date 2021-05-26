-- App Selection
hs.hotkey.bind({"ctrl", "cmd"}, "f", function()
  hs.application.launchOrFocus("Finder")
end)
hs.hotkey.bind({"ctrl", "cmd"}, "t", function()
  hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({"ctrl", "cmd"}, "d", function()
  hs.application.launchOrFocus("Dash")
end)
hs.hotkey.bind({"ctrl", "cmd"}, "b", function()
  hs.application.launchOrFocus("Firefox")
end)
-- m for "music"
hs.hotkey.bind({"ctrl", "cmd"}, "m", function()
  hs.application.launchOrFocus("Music")
end)
-- c for "chat"
hs.hotkey.bind({"ctrl", "cmd"}, "c", function()
  hs.application.launchOrFocus("Messages")
end)

-- Hints
-- hs.hints.hintChars = {'a', 'o', 'e', 'u', 'i', 'd', 'h', 't', 'n', 's'}
hs.hints.style = 'vimperator'
hs.hotkey.bind({"ctrl", "cmd"}, 'h', function()
  hs.hints.windowHints()
end)
