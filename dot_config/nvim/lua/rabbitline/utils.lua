local M = {}

-- identify the union of sections
M.union = function(tbl)
  if not tbl[1] then
    error('empty list or table is passed to union, you should pass a list.')
  end
  return {union = tbl}
end

M.get_buf = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

M.get_buf_name = function()
  return vim.api.nvim_buf_get_name(M.get_buf())
end

M.get_win_option = function(opt)
  return vim.api.nvim_win_get_option(vim.g.statusline_winid, opt)
end

M.get_buf_option = function(opt)
  return vim.api.nvim_buf_get_option(M.get_buf(), opt)
end

return M
