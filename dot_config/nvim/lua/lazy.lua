local function lazy_map()
  local m = require('utils').map
  for _, paras in ipairs(require('mappings').paras_tbl) do
    m(unpack(paras))
  end
end

local function lazy_plug()
  -- require('pairs'):setup()
  vim.cmd('pa targets.vim')
  vim.cmd('pa ultisnips')
  vim.cmd('pa neogen')
  vim.cmd('pa vim-fugitive')
  vim.cmd('pa gitsigns.nvim')
  require('gitsigns').setup()
  vim.cmd('pa neogen')
  require('neogen').setup{enabled = true}
  require('plug.surround')
  require('plug.treesitter')
  require('plug.indent_line')
  require('plug.telescope')
  vim.cmd([[au User CocNvimInit ++once lua require('plugs.coc').setup()]])
  vim.cmd('pa coc.nvim')
  -- require('plug.coc').setup()
  -- require('plug.coc')
end

local function lazy_autocmd()
  vim.cmd([[
    aug Packer
      au!
      au BufWritePost */plug/packer.lua so <afile> | PackerCompile
    aug END

    aug RecoverPos
      au!
      au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"zz" |
        \ endif
    aug END

    aug Coc
      au!
      au User CocLocationsChange ++nested lua require('plug.coc').jump2loc()
      au User CocDiagnosticChange ++nested lua require('plug.coc').diagnostic_change()
      au CursorHold * sil! call CocActionAsync('highlight', '', v:lua.require('plug.coc').hl_fallback)
      au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      au VimLeavePre * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -- -' . g:coc_process_pid) | endif
    aug END
  ]])
  require('rabbitline').stl.set_autocommands()
end

vim.schedule(function()
  vim.defer_fn(lazy_map, 0)
  vim.defer_fn(lazy_plug, 10)
  vim.defer_fn(lazy_autocmd, 50)
end)
