-- URL Dispatcher
hs.loadSpoon("URLDispatcher")
local Zoom = "us.zoom.xos"
local Chrome = "com.google.Chrome"
spoon.URLDispatcher.url_patterns = {
  {"https?://zoom.us/j/", Zoom},
  {"https?://%w+.zoom.us/j/", Zoom}
}
spoon.URLDispatcher.default_handler = Chrome
spoon.URLDispatcher:start()
