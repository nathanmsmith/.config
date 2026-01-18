vim.g["test#custom_strategies"] = {
  iterm = function(test_command)
    print("Test command: " .. test_command)
    -- Use AppleScript for much faster iTerm2 integration
    local escaped_command = test_command:gsub("\\", "\\\\"):gsub('"', '\\"')
    local applescript = string.format(
      [[
      tell application "iTerm2"
        tell current window
          set testTab to missing value

          repeat with aTab in tabs
            tell aTab
              tell current session
                if name is "Tests" then
                  set testTab to aTab
                  exit repeat
                end if
              end tell
            end tell
          end repeat

          if testTab is missing value then
            set testTab to (create tab with default profile)
            tell testTab
              select
              tell current session
                set name to "Tests"
                write text "%s"
              end tell
            end tell
          else
            tell testTab
              select
              tell current session
                write text "%s"
              end tell
            end tell
          end if
        end tell
      end tell
    ]],
      escaped_command,
      escaped_command
    )

    local result = vim.fn.system({ "osascript", "-e", applescript })
    local exit_code = vim.v.shell_error

    if exit_code ~= 0 then
      print("AppleScript error (exit code " .. exit_code .. "): " .. result)
    end
  end,
}

vim.g["test#custom_transformations"] = {
  neovim_functional = function(cmd)
    local current_file = vim.fn.expand("%:p")
    if current_file:match("Developer/neovim/") and current_file:match("%.lua$") and current_file:match("test") then
      local test_file = vim.fn.expand("%:.")
      return "make functionaltest BUSTED_ARGS='-v' TEST_FILE=" .. test_file
    end
    return cmd
  end,
}

vim.g["test#transformation"] = "neovim_functional"

vim.g["VimuxRunnerType"] = "window"
vim.g["VimuxRunnerName"] = "tests"
vim.g["test#preserve_screen"] = 1
vim.g["test#echo_command"] = 0

if os.getenv("TMUX") then
  vim.g["test#strategy"] = "vimux"
else
  vim.g["test#strategy"] = "iterm"
end

vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { silent = true, desc = "Run nearest [t]est" })
vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { silent = true, desc = "Run file [T]ests" })
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", { silent = true, desc = "Run [a]ll tests" })
vim.keymap.set("n", "<leader>l", ":TestSuite<CR>", { silent = true, desc = "Run [l]ast test" })
