-- Caffeine
caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
  if state then
    caffeine:setIcon("images/active.pdf")
  else
    caffeine:setIcon("images/inactive.pdf")
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

function caffeineOff()
  hs.caffeinate.set("displayIdle", false, true)
  setCaffeineDisplay(false)
end

hs.urlevent.bind("caffeine-toggle", function()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end)

if caffeine then
  -- Initialize callback
  caffeine:setClickCallback(caffeineClicked)

  -- Initialize display to current displayIdle value
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
