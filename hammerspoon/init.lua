hs.window.animationDuration = 0

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Variable names, no they aren't garbage collected
c = require('caffeine')
b = require('bluetooth')
p = require('paste')
-- u = require('urls')
f = require('focus')
w = require('window-management')

-- EjectMenu
hs.loadSpoon("EjectMenu")
spoon.EjectMenu.show_in_menubar = false
spoon.EjectMenu.notify = true
spoon.EjectMenu:start()

-- Handle various willSleep/didWake actions.
-- Uses functions from caffeine and bluetooth modules.
function onSleepWatcher(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    bluetooth("off")

    -- Display keeping displays on when sleep happens.
    -- This means if the computer wakes up, it can go back to sleep.
    caffeineOff()
  elseif event == hs.caffeinate.watcher.screensDidWake then
    bluetooth("on")
  end
end

sleepWatcher = hs.caffeinate.watcher.new(onSleepWatcher)
sleepWatcher:start()
