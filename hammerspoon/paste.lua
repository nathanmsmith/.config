-- Defeat paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

local function cleanPasteboard()
  local pb = hs.pasteboard.contentTypes()
  local contains = hs.fnutils.contains
  if contains(pb, "com.apple.webarchive") and contains(pb, "public.rtf") then
    hs.pasteboard.setContents(hs.pasteboard.getContents())
  end
end

local messagesWindowFilter = hs.window.filter.new(false):setAppFilter('Messages')
messagesWindowFilter:subscribe(hs.window.filter.windowFocused, cleanPasteboard)
