vim.g["test#custom_strategies"] = {
  iterm = function(test_command)
    print("Test command: " .. test_command)
    -- Use Python for iTerm2 integration with proper tab management
    local escaped_command = test_command:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("'", "'\\''")
    local python_script = string.format(
      [[
import iterm2
import sys

async def main(connection):
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window
    if window is None:
        print("No current window", file=sys.stderr)
        sys.exit(1)

    # Look for existing tab with title containing "Tests"
    test_tab = None
    for tab in window.tabs:
        name = await tab.current_session.async_get_variable("user.test_runner_tab")
        if name == "1" or "Tests" in tab.current_session.name:
            test_tab = tab
            break

    if test_tab is None:
        # Create new tab
        test_tab = await window.async_create_tab()

    # Mark this tab as the test runner tab and set title
    await test_tab.current_session.async_set_variable("user.test_runner_tab", "1")
    await test_tab.current_session.async_set_name("Tests")
    await test_tab.async_select()
    await test_tab.current_session.async_send_text('%s\n')

iterm2.run_until_complete(main)
]],
      escaped_command
    )

    local result = vim.fn.system({ "uv", "run", "--with", "iterm2", "python3", "-c", python_script })
    local exit_code = vim.v.shell_error

    if exit_code ~= 0 then
      print("Python/iTerm2 error (exit code " .. exit_code .. "): " .. result)
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
