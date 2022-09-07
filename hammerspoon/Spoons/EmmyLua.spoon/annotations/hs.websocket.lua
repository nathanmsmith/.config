--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Simple websocket client.
---@class hs.websocket
local M = {}
hs.websocket = M

-- Closes a websocket connection.
--
-- Parameters:
--  * None
--
-- Returns:
--  * The `hs.websocket` object
function M:close() end

-- Creates a new websocket connection.
--
-- Parameters:
--  * url - The URL to the websocket
--  * callback - A function that's triggered by websocket actions.
--
-- Returns:
--  * The `hs.websocket` object
--
-- Notes:
--  * The callback should accept two parameters.
--  * The first paramater is a string with the following possible options:
--   * open - The websocket connection has been opened
--   * closed - The websocket connection has been closed
--   * fail - The websocket connection has failed
--   * received - The websocket has received a message
--   * pong - A pong request has been received
--  * The second parameter is a string with the recieved message or an error message.
--  * Given a path '/mysock' and a port of 8000, the websocket URL is as follows:
--   * ws://localhost:8000/mysock
--   * wss://localhost:8000/mysock (if SSL enabled)
function M.new(url, callback, ...) end

-- Sends a message to the websocket client
--
-- Parameters:
--  * message - A string containing the message to send
--
-- Returns:
--  * The `hs.websocket` object
function M:send(message, ...) end

-- Gets the status of a websocket.
--
-- Parameters:
--  * None
--
-- Returns:
--  * A string containing one of the following options:
--   * connecting
--   * open
--   * closing
--   * closed
--   * unknown
---@return string
function M:status() end
