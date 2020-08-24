-- URL Dispatcher
hs.loadSpoon("URLDispatcher")
local Zoom = "us.zoom.xos"
local Browser = "com.google.Chrome"
spoon.URLDispatcher.url_patterns = {
  {"https?://zoom.us/j/", Zoom},
  {"https?://%w+.zoom.us/j/", Zoom}
}
spoon.URLDispatcher.default_handler = Browser
spoon.URLDispatcher:start()
