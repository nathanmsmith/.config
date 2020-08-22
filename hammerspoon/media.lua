-- Always route play/pause to Spotify
-- Inspired by https://github.com/Hammerspoon/Spoons/blob/master/Source/HighSierraiTunesMediaFix.spoon/init.lua
function mediaKeyCallback(event)
  local delete = false

  local data = event:systemKey()

  if data["down"] == false or data["repeat"] == true then
    if data["key"] == "PLAY" then
      hs.spotify.playpause()
      delete = true
    elseif data["key"] == "FAST" then
      hs.spotify.next()
      delete = true
    elseif data["key"] == "REWIND" then
      hs.spotify.previous()
      delete = true
    end
  end

  return delete, nil
end

hs.eventtap.new({hs.eventtap.event.types.NSSystemDefined}, mediaKeyCallback)
