hs.window.animationDuration = 0

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

Broswer = "com.apple.Safari"
hs.hotkey.bind({"ctrl", "cmd"}, "b", function()
  hs.application.launchOrFocusByBundleID(Browser)
end)

-- Variable names, no they aren't garbage collected
b = require('bluetooth')
c = require('caffeine')
p = require('paste')
-- u = require('urls')
f = require('focus')
w = require('window-management')
