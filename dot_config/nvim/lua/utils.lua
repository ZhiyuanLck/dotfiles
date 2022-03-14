local M    = {}
local fn   = vim.fn
local cmd  = vim.cmd
local api  = vim.api
local Path = require("plenary.path")

-- get cwd
function M.cwd()
  return fn.expand('%:p:h')
end

local function is_root(pathname)
  if Path.path.sep == "\\" then
    return string.match(pathname, "^[A-Z]:\\?$")
  end
  return pathname == "/"
end

-- try find root dir
-- @return root dir or cwd
function M.find_root()
  root_patterns = vim.g.root_patterns or {'.git', '.root', '.project'}
  local p = Path:new(M.cwd())
  local i = 1
  while (not is_root(p.filename)) do
    for _, pattern in ipairs(root_patterns) do
      if p:joinpath(pattern):exists() then
        return p.filename
      end
    end
    p = p:parent()
  end
  return M.cwd()
end

-- load packages by list
function M.load(packages)
  for _, package in ipairs(packages) do
    vim.cmd('pa ' .. package)
  end
end

local function get_defaults(mode)
  return {noremap = true, silent = mode ~= 'c'}
end

-- map keys
function M.map(mode, lhs, rhs, opts)
  opts = opts or get_defaults(mode)
  api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- map buffer keys
function M.bmap(bufnr, mode, lhs, rhs, opts)
  opts = opts or get_defaults(mode)
  api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

-- operate on previous window
-- u for scroll up
-- d for scroll down
-- s for sync linenr
function M.exe_prev(mode)
  if fn.winnr('$') < 1 then
    return
  end
  local linenr = fn.line('.')
  cmd('noautocmd silent! wincmd p')
  if mode == 'u' then
    cmd([[exec "normal! \<c-u>"]])
  elseif mode == 'd' then
    cmd([[exec "normal! \<c-d>"]])
  elseif mode == 's' then
    cmd('normal! ' .. linenr .. 'Gzz')
  end
  cmd('noautocmd silent! wincmd p')
end

local function if_last_win()
  local n = 0
  local win_id = fn.win_getid()
  for _, tab in ipairs(api.nvim_list_tabpages()) do
    for _, win in ipairs(api.nvim_tabpage_list_wins(tab)) do
      if win_id == win then n = n + 1 end
      if n > 1 then return false end
    end
  end
  return true
end

-- smart close
function M.close()
  if vim.bo.filetype == 'help' or if_last_win() then
    cmd('quit')
  else
    cmd('bwipeout | quit')
  end
end

return M
