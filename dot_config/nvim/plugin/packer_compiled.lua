-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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
local package_path_str = "/home/zhiyuan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/zhiyuan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/zhiyuan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/zhiyuan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/zhiyuan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
  ["coc.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  neogen = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/neogen",
    url = "https://github.com/danymat/neogen"
  },
  nerdcommenter = {
    keys = { { "", "<Plug>NERDCommenterToggle" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\no\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0\20ColorizerToggle\bcmd\bvim\1\3\0\0\blua\bvim\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-treesitter"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["smart-pairs"] = {
    config = { "\27LJ\2\n;\0\0\4\0\3\0\b6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0004\3\0\0B\0\3\1K\0\1\0\nsetup\npairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/smart-pairs",
    url = "https://github.com/ZhiyuanLck/smart-pairs"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/startuptime.vim",
    url = "https://github.com/tweekmonster/startuptime.vim"
  },
  ["surround.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/surround.nvim",
    url = "https://github.com/blackCauldron7/surround.nvim"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-coc.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/telescope-coc.nvim",
    url = "https://github.com/fannheyward/telescope-coc.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ultisnips = {
    after_files = { "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/ultisnips/after/plugin/UltiSnips_after.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/ultisnips",
    url = "https://github.com/sirver/ultisnips"
  },
  ["vim-diary"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vim-diary",
    url = "https://github.com/ZhiyuanLck/vim-diary"
  },
  ["vim-easy-align"] = {
    keys = { { "", "<Plug>(EasyAlign)" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-sneak"] = {
    keys = { { "", "<Plug>Sneak_s" }, { "", "<Plug>Sneak_S" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-visual-multi"] = {
    keys = { { "", "<c-n>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vim-sneak
time([[Setup for vim-sneak]], true)
try_loadstring("\27LJ\2\nD\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0'\2\3\0)\3\1\0B\0\3\1K\0\1\0\16sneak#label\17nvim_set_var\bapi\bvim\0", "setup", "vim-sneak")
time([[Setup for vim-sneak]], false)
-- Setup for: vimtex
time([[Setup for vimtex]], true)
try_loadstring("\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rplug.tex\frequire\0", "setup", "vimtex")
time([[Setup for vimtex]], false)
-- Setup for: packer.nvim
time([[Setup for packer.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\2\0\3\0\0056\0\0\0009\0\1\0009\0\2\0B\0\1\1K\0\1\0\23vm#plugs#permanent\afn\bvimç\1\1\0\3\0\6\1\0196\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\4Ä6\0\0\0009\0\1\0+\1\0\0=\1\2\0006\0\0\0009\0\1\0009\0\3\0\t\0\0\0X\0\4Ä6\0\0\0009\0\4\0003\2\5\0B\0\2\1K\0\1\0\0\rschedule\24loaded_visual_multi\25loaded_nerd_comments\6g\bvim\2\0", "setup", "packer.nvim")
time([[Setup for packer.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'startuptime.vim'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
vim.schedule(function() vim.defer_fn(function()
time([[Defining lazy-load keymaps]], true)
pcall(vim.cmd, [[noremap <unique><silent> <c-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>c-n>", prefix = "" }, _G.packer_plugins)<cr>]])
pcall(vim.cmd, [[noremap <unique><silent> <Plug>NERDCommenterToggle <cmd>lua require("packer.load")({'nerdcommenter'}, { keys = "<lt>Plug>NERDCommenterToggle", prefix = "" }, _G.packer_plugins)<cr>]])
pcall(vim.cmd, [[noremap <unique><silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]])
pcall(vim.cmd, [[noremap <unique><silent> <Plug>Sneak_s <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "<lt>Plug>Sneak_s", prefix = "" }, _G.packer_plugins)<cr>]])
pcall(vim.cmd, [[noremap <unique><silent> <Plug>Sneak_S <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "<lt>Plug>Sneak_S", prefix = "" }, _G.packer_plugins)<cr>]])
time([[Defining lazy-load keymaps]], false)
end, 100) end)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType plaintex ++once lua require("packer.load")({'vimtex'}, { ft = "plaintex" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'smart-pairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/zhiyuan/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end