hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()


-- Defeat paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)


require('caffeine')
require('urls')
require('focus')
