--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Route URLs to different applications with pattern matching
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/URLDispatcher.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/URLDispatcher.spoon.zip)
--
-- Sets Hammerspoon as the default browser for HTTP/HTTPS links, and
-- dispatches them to different apps according to the patterns defined
-- in the config. If no pattern matches, `default_handler` is used.
---@class spoon.URLDispatcher
local M = {}
spoon.URLDispatcher = M

-- If true, handle Slack-redir URLs to apply the rule on the destination URL. Defaults to `true`
M.decode_slack_redir_urls = nil

-- Bundle ID for default URL handler. (Defaults to `"com.apple.Safari"`)
M.default_handler = nil

-- Dispatch a URL to an application according to the defined `url_patterns`.
--
-- Parameters (according to the [httpCallback](http://www.hammerspoon.org/docs/hs.urlevent.html#httpCallback) specification):
--  * scheme - A string containing the URL scheme (i.e. "http")
--  * host - A string containing the host requested (e.g. "www.hammerspoon.org")
--  * params - A table containing the key/value pairs of all the URL parameters
--  * fullURL - A string containing the full, original URL
function M:dispatchURL(scheme, host, params, fullUrl, ...) end

-- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
M.logger = nil

-- Start dispatching URLs according to the rules
function M:start() end

-- URL dispatch rules.
-- A table containing a list of dispatch rules. Each rule should be its own table in the format: `{ "url pattern", "application bundle ID", "function" }`, and they are evaluated in the order they are declared. Note that the patterns are [Lua patterns](https://www.lua.org/pil/20.2.html) and not regular expressions. Defaults to an empty table, which has the effect of having all URLs dispatched to the `default_handler`. If "application bundle ID" is specified, that application will be used to open matching URLs. If no "application bundle ID" is specified, but "function" is provided (and is a Lua function) it will be called with the URL.
M.url_patterns = nil

