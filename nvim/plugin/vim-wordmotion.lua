vim.pack.add({
  "https://github.com/chaoren/vim-wordmotion",
})

local before_words = function(s, w)
  local before = [[\%(]] .. w .. s .. [[*\)\@<=]]
  return before .. s
end

local after_words = function(s, w)
  local after = [[\%(]] .. s .. "*" .. w .. [[\)\@=]]
  return s .. after
end

local between_words = function(s, w)
  local before = [[\%(]] .. w .. s .. [[*\)\@<=]]
  local after = [[\%(]] .. s .. "*" .. w .. [[\)\@=]]
  return before .. s .. after
end

local alpha = "[[:lower:][:upper:]]"
local alnum = "[[:lower:][:upper:][:digit:]]"
local alnum_with_graph = "[[:lower:][:upper:][:digit:][:graph:]]"

vim.g.wordmotion_spaces = {
  between_words("_", alnum),
  between_words("-", alpha),
  between_words([[\.]], alnum),
  before_words(",", alnum_with_graph),
  after_words(",", alnum_with_graph),
  before_words(":", alnum_with_graph),
  after_words(":", alnum_with_graph),
  before_words('"', alnum_with_graph),
  after_words('"', alnum_with_graph),
  before_words("'", alnum_with_graph),
  after_words("'", alnum_with_graph),
  before_words("(", alnum),
  after_words("(", alnum),
  before_words(")", alnum),
  after_words(")", alnum),
  before_words("`", alnum_with_graph),
  after_words("`", alnum_with_graph),
  before_words("%", alnum_with_graph),
  after_words("%", alnum_with_graph),
  before_words("\\[", alnum),
  after_words("\\[", alnum),
  before_words("\\]", alnum),
  after_words("\\]", alnum),
  before_words("{", alnum),
  after_words("{", alnum),
  before_words("}", alnum),
  after_words("}", alnum),
  before_words(";", alnum),
  after_words(";", alnum_with_graph),
  before_words("?", alnum_with_graph),
  after_words("?", alnum_with_graph),
  before_words("=", alnum),
  after_words("=", alnum),
  before_words("<", alnum),
  after_words("<", alnum),
  before_words(">", alnum),
  after_words(">", alnum),
  before_words("/", alnum_with_graph),
  after_words("/", alnum_with_graph),
}
