local M   = {}
local g   = vim.g
local cmd = vim.cmd

function M.setup()
  g.coc_config_home = {}
  g.coc_global_extensions = {
    'coc-json', 'coc-cmake', 'coc-pyright', 'coc-vimtex', 'coc-sh',
    'coc-clangd', 'coc-sumneko-lua', 'coc-spell-checker', 'coc-yank',
  }
  g.coc_enable_locationlist = 0
  g.coc_default_semantic_highlight_groups = 1
end

return M
