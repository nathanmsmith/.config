hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local caffeine = hs.loadSpoon("Caffeine")
caffeine:bindHotkeys({toggle = {{"ctrl", "alt", "cmd"}, "a"}})
caffeine:start()

hs.inspect(spoon.Caffeine)



-- Defeat paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
