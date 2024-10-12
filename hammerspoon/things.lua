hs.hotkey.bind({ "cmd" }, "p", function()
  local app = hs.application.get("Things")
  if app then
    hs.eventtap.keyStroke({ "cmd" }, "f", 0, app)
  end
end)
