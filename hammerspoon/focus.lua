local modules = require("helpers.modules")

local log = hs.logger.new("focus")
log.setLogLevel(5)
log.i("Initializing")

-- App Selection
hs.hotkey.bind({ "ctrl", "cmd" }, "f", function()
  hs.application.launchOrFocus("Finder")
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "t", function()
  if modules.isModuleAvailable("stripe") then
    hs.application.launchOrFocus("iTerm")
  else
    hs.application.launchOrFocus("iTerm")
    -- hs.application.launchOrFocus("Ghostty")
  end
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "d", function()
  hs.application.launchOrFocus("Dash")
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "p", function()
  hs.application.launchOrFocus("Preview")
end)
-- Browser:
-- Focus Chrome if running
-- else, focus Firefox
-- else, Safari
hs.hotkey.bind({ "ctrl", "cmd" }, "b", function()
  log.i("Focusing to browser")
  local chrome = hs.application.get("Google Chrome")
  if chrome then
    log.i("Found Chrome, focusing")
    chrome:setFrontmost()
  else
    local firefox = hs.application.get("Firefox")
    if firefox then
      log.i("Found Firefox, focusing")
      firefox:setFrontmost()
    else
      log.i("Found Safari, focusing")
      hs.application.launchOrFocus("Safari")
    end
  end
end)
-- m for "music"
hs.hotkey.bind({ "ctrl", "cmd" }, "m", function()
  hs.application.launchOrFocus("Music")
end)
-- c for "chat"
hs.hotkey.bind({ "ctrl", "cmd" }, "c", function()
  if modules.isModuleAvailable("stripe") then
    hs.application.launchOrFocus("Slack")
  else
    hs.application.launchOrFocus("Messages")
  end
end)

-- Hints
-- hs.hints.hintChars = {'a', 'o', 'e', 'u', 'i', 'd', 'h', 't', 'n', 's'}
hs.hints.style = "vimperator"
hs.hotkey.bind({ "ctrl", "cmd" }, "h", function()
  hs.hints.windowHints()
end)
