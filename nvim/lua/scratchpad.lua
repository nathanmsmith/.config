local scratchpath = vim.fn.stdpath("config") .. "/lua/scratchpad.lua"

vim.api.nvim_create_user_command("Scratchpad", function()
  vim.cmd("tabedit " .. scratchpath)
  vim.cmd("tcd " .. vim.fn.stdpath("config"))
end, { desc = "Open Scratchpad, a hot-reloading file. Try out ideas here.", nargs = 0 })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = scratchpath,
  group = vim.api.nvim_create_augroup("Scratchpad", { clear = true }),
  callback = function()
    vim.cmd("source " .. scratchpath)
    vim.notify("Reloaded scratchpad 📝")
  end,
  desc = "Reload Lua files in Neovim config directory on save",
})

vim.api.nvim_create_user_command("Datapath", function()
  vim.cmd("edit " .. vim.fn.stdpath("data"))
  vim.cmd("tcd " .. vim.fn.stdpath("data"))
end, { desc = "Open the datapath for Neovim", nargs = 0 })

-- TODO: command to :lua print([VISUAL SELECTION])
vim.api.nvim_create_user_command("Lua", function(opts)
  local code_to_run
  if opts.range ~= 0 then
    -- Command was called with a range (visual selection or line range)
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getregion(start_pos, end_pos)
    code_to_run = table.concat(lines, "\n")
  else
    -- Command was called without a range
    code_to_run = opts.args
  end

  print("> " .. code_to_run)
  local result = loadstring("return " .. code_to_run)()
  local stringified_result = vim.inspect(result)
  vim.notify("-> " .. stringified_result)
  -- Register 'l' for "Lua"
  vim.fn.setreg("l", result)
end, { desc = "Run some arbitrary Lua code", nargs = "?", range = true })

-- TODO: improve :FileName commpand. Replace pbcopy with Neovim buffers.
--
-- TODO: Neovim's telescope should grep all of help, not just search help tags
--
-- TODO: Syntax highlighting for gitcommit files?
--
--

-- TODO: accept ranges
local Path = require("plenary.path")

---@class OpenGitHubUrlArgs
---@field line1 integer # Start line number of the range
---@field line2 integer # End line number of the range
---@field view string # The view type (e.g., "blob", "tree")
---@field action "open"|"copy" # Action to perform with the URL

---@param args OpenGitHubUrlArgs
---@return nil
local function open_github_url(args)
  local repo_root = vim.fs.root(0, { ".git" })
  local relative_path = Path:new(vim.fn.expand("%:p")):make_relative(repo_root)

  -- Get the current branch name
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")

  -- Get the repository name from the remote URL
  local remote_origin_url = vim.fn.system("git config --get remote.origin.url")
  local clean_remote_origin_url = remote_origin_url:gsub("%.git", ""):gsub("%s", "")

  local host, owner, repo = string.match(clean_remote_origin_url, "^(.+):(.+)/(.+)$")

  if host == nil then
    host, owner, repo = string.match(clean_remote_origin_url, "^https?://(.+)/(.+)/(.+)$")
  end

  local line_output = string.format("L%d-L%d", args.line1, args.line2)
  if args.line1 == args.line2 then
    line_output = string.format("L%d", args.line1)
  end

  local github_url =
    string.format("https://%s/%s/%s/%s/%s/%s#%s", host, owner, repo, args.view, branch, relative_path, line_output)

  if args.action == "open" then
    vim.ui.open(github_url)
    vim.notify("Opened GitHub URL: " .. github_url)
  else
    vim.fn.setreg("+", github_url)
    vim.notify("Copied: " .. github_url)
  end
end

-- TODO: Where are the help pages loaded for Neovim?
--       Associate with Neovim GitHub page.
--       open that page on master/main
--
--        if :Blame is used in a help file
--        then -> vim.ui.open("https://github.com/neovim/neovim/blame/master/runtime/doc/diagnostic.txt#L70")
--
--        Future improvement ideas:
--          - handle plugins. can I use the filepath of the absolute path of the help file to determine a git directory?
--            Use git remote?
--            e.g.,
--          --       filepath: /opt/homebrew/Cellar/neovim/0.10.1/share/nvim/runtime/doc/ -> neovim/neovim github link (https://github.com/neovim/neovim/blame/master)
--          --       filepath: ~/.local/share/nvim/lazy/{plugin}/doc/

vim.api.nvim_create_user_command("GBrowse", function(opts)
  if opts.bang then
    open_github_url({ view = "blob", action = "copy", line1 = opts.line1, line2 = opts.line2 })
  else
    open_github_url({ view = "blob", action = "open", line1 = opts.line1, line2 = opts.line2 })
  end
end, { desc = "Open a file in GitHub", nargs = 0, bang = true, range = true })
vim.api.nvim_create_user_command("GBlame", function(opts)
  if opts.bang then
    open_github_url({ view = "blame", action = "copy", line1 = opts.line1, line2 = opts.line2 })
  else
    open_github_url({ view = "blame", action = "open", line1 = opts.line1, line2 = opts.line2 })
  end
end, { desc = "Open a file in GitHub", nargs = 0, bang = true, range = true })
