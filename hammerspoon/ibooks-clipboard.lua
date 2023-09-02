local m = {}

local app_watcher = nil
local pasteboard_watcher = nil

local function watch_for_books_app(appName, event)
  if appName == "Books" then
    if event == hs.application.watcher.activated then
      m.log.i("Enable copy override")
      pasteboard_watcher:start()
    else
      m.log.i("Disable copy override")
      pasteboard_watcher:stop()
    end
  end
end

local function trim_books_cruft(contents)
  m.log.i("Contents: " .. contents)
  local trimmed_contents = string.match(contents, "“(.*)”")
  if trimmed_contents == nil then
    m.log.i("No Books cruft to trim!")
  else
    m.log.i("Trimmed contents: " .. trimmed_contents)
    hs.pasteboard.setContents(trimmed_contents)
  end
end

function m.start()
  app_watcher = hs.application.watcher.new(watch_for_books_app)
  pasteboard_watcher = hs.pasteboard.watcher.new(trim_books_cruft)
  app_watcher:start()
end

function m.stop()
  app_watcher:stop()
  pasteboard_watcher:stop()
  app_watcher = nil
  pasteboard_watcher = nil
end

return m
