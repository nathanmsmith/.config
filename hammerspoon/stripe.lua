-- Close all Chrome windows
closeWindowsOnQuit = hs.hotkey.bind({"cmd"}, "q", function()
  local chrome = hs.application.get("Google Chrome")
  local windows = chrome:allWindows()
  for _, window in pairs(windows) do
    window:close()
  end
  chrome:kill()
end)
closeWindowsOnQuit:disable()


hs.window.filter.new("Google Chrome")
    :subscribe(hs.window.filter.windowFocused,function() closeWindowsOnQuit:enable() end)
    :subscribe(hs.window.filter.windowUnfocused,function() closeWindowsOnQuit:disable() end)
    :subscribe(hs.window.filter.windowDestroyed,function() closeWindowsOnQuit:disable() end)
