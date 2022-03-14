local M = {}

local u = require('rabbitline.utils')

function M.active()
  return vim.g.statusline_winid == vim.fn.win_getid(vim.api.nvim_win_get_number(0))
end

function M.inactive()
  return not M.active()
end

function M.buf_empty()
  return vim.api.nvim_buf_get_name(u.get_buf()) == ''
end

function M.buf_not_empty()
  return not M.buf_empty()
end

function M.buf_changed()
  return vim.fn.getbufinfo(u.get_buf())[1].changed == 1
end

function M.read_only()
  return not u.get_buf_option('modifiable')
end

return M
