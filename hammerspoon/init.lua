hs.window.animationDuration = 0

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Variable names, no they aren't garbage collected
c = require("caffeine")
-- b = require('bluetooth')
p = require("paste")
-- u = require('urls')
f = require("focus")
w = require("window-management")

-- Handle various willSleep/didWake actions.
-- Uses functions from caffeine and bluetooth modules.
function onSleepWatcher(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    -- bluetooth("off")

    -- Display keeping displays on when sleep happens.
    -- This means if the computer wakes up, it can go back to sleep.
    caffeineOff()
  elseif event == hs.caffeinate.watcher.screensDidWake then
    -- bluetooth("on")
  end
end

sleepWatcher = hs.caffeinate.watcher.new(onSleepWatcher)
sleepWatcher:start()


function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

if isModuleAvailable("stripe") then
  s = require("stripe")
end
