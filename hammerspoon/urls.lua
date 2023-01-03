-- URL Dispatcher
-- hs.loadSpoon("URLDispatcher")
-- local Zoom = "us.zoom.xos"
-- local Browser = "com.google.Chrome"

-- spoon.URLDispatcher.url_patterns = {
--   { "https?://zoom.us/j/", Zoom },
--   { "https?://%w+.zoom.us/j/", Zoom },
-- }
-- spoon.URLDispatcher.default_handler = Browser
-- spoon.URLDispatcher:start()

local log = hs.logger.new("callback")
log.setLogLevel(5)

---   * scheme - A string containing the URL scheme (i.e. "http")
---   * host - A string containing the host requested (e.g. "www.hammerspoon.org")
---   * params - A table containing the key/value pairs of all the URL parameters
---   * fullURL - A string containing the full, original URL
---   * senderPID - An integer containing the PID of the application that opened the URL, if available (otherwise -1)
hs.urlevent.httpCallback = function(_scheme, _host, _params, fullURL, _senderPID)
  local chrome = hs.application.get("com.google.Chrome")
  if chrome then
    log.i("Found Chrome, opening")
    hs.urlevent.openURLWithBundle(fullURL, "com.google.Chrome")
  else
    local firefox = hs.application.get("Firefox")
    if firefox then
      log.i("Found Firefox, opening")
      hs.urlevent.openURLWithBundle(fullURL, "org.mozilla.firefox")
    else
      log.i("Opening with Safari")
      hs.urlevent.openURLWithBundle(fullURL, "com.apple.Safari")
    end
  end
end
