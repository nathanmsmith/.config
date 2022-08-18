local rubocop = function()
  return {
    exe = "bundle exec rubocop",
    args = { "--autocorrect-all", "-f", "quiet", "--stderr", "--stdin", "%:p" },
    stdin = true,
    ignore_exitcode = true,
  }
end
return rubocop
