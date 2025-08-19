-- Shared JSX matchup configuration for React files
-- to support JSX elements with dots in their names (e.g., <view.div>)

local M = {}

function M.setup()
  if vim.g.loaded_matchup then
    -- Define custom match patterns for JSX elements with dots
    -- This extends the default HTML patterns to include dots in tag names
    vim.b.match_words = 
      '<\\(\\w\\+\\)\\(\\.\\w\\+\\)*\\%(\\s\\+[^>]*\\)\\?\\%(\\s*/\\)\\@<!>:' ..
      '</\\1\\(\\.\\w\\+\\)*>,' ..
      '<\\(\\w\\+\\)\\(\\.\\w\\+\\)*\\%(\\s\\+[^>]*\\)\\?\\s*/>:' ..
      '<\\(\\w\\+\\)\\(\\.\\w\\+\\)*\\%(\\s\\+[^>]*\\)\\?\\s*/>,' ..
      '\\<if\\>:\\<else\\>:\\<endif\\>,' ..
      '\\<for\\>:\\<endfor\\>,' ..
      '\\<while\\>:\\<endwhile\\>'
  end
end

return M