local M = {}

M.brackets = {'', ''}

M.mode = {
  rabbit = '🐇',
  pig    = '🐷'
}
-- M.mode = {rabbit = '🐇', pig = '🐷'}

M.file_path = {
  modified  = '',
  read_only = '',
}

M.pos = {
  line    = '',
  col     = '',
  percent = 'Ξ',
}

local icons = {
  diagnostic = {
    -- error = " ",
    -- warn = " ",
    -- info = " "
  },
  diff = {
    -- add = " ",
    -- modified = " ",
    -- remove = " "
  },
  file = {
    -- modified = '⨁ ',
    -- modified = '✎',
  },
  -- terminal  = iconz.get("vim-terminal-mode")
}

return M
