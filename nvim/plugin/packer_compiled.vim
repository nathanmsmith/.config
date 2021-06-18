" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/nathan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/nathan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/nathan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/nathan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/nathan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/night-owl.vim"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-colorizer.lua"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/opt/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-bundler"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-bundler"
  },
  ["vim-characterize"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-characterize"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-peekaboo"
  },
  ["vim-rails"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-rails"
  },
  ["vim-rake"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-rake"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-ruby"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-ruby"
  },
  ["vim-signature"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-signature"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-rubyblock"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-textobj-rubyblock"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-textobj-xmlattr"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-textobj-xmlattr"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  },
  ["vim-visual-star-search"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-visual-star-search"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/nathan/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-treesitter', 'nvim-treesitter-textobjects', 'playground'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'nvim-treesitter', 'nvim-treesitter-textobjects', 'playground'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-treesitter', 'nvim-treesitter-textobjects', 'playground'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-treesitter', 'nvim-treesitter-textobjects', 'playground'}, { ft = "css" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], true)
vim.cmd [[source /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]]
time([[Sourcing ftdetect script at: /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], false)
time([[Sourcing ftdetect script at: /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gomod.vim]], true)
vim.cmd [[source /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gomod.vim]]
time([[Sourcing ftdetect script at: /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gomod.vim]], false)
time([[Sourcing ftdetect script at: /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], true)
vim.cmd [[source /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]]
time([[Sourcing ftdetect script at: /Users/nathan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
