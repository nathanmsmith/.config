hs.window.animationDuration = 0

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Variable names, no they aren't garbage collected
b = require('bluetooth')
c = require('caffeine')
p = require('paste')
u = require('urls')
f = require('focus')
w = require('window-management')

-- -- VimMode
-- local VimMode = hs.loadSpoon('VimMode')
-- local vim = VimMode:new()

-- vim
--   :disableForApp('Code')
--   :disableForApp('iTerm')
--   :disableForApp('iTerm 2')
--   :disableForApp('kitty')
--   :disableForApp('zoom.us')
--   :enterWithSequence('jk', 160)
--   :shouldDimScreenInNormalMode(false)
