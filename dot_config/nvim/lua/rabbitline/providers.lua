local M = {}

local icons = require('rabbitline.icons')
local c     = require('rabbitline.conditions')
local u     = require('rabbitline.utils')
local mode  = require('rabbitline.providers.mode')

M.mode_mode      = mode.mode_mode
M.mode_map       = mode.mode_map
M.mode_short_map = mode.mode_short_map

M.get_path = function()
  local bufname = u.get_buf_name()
  local path_sep = require('plenary.path').path.sep
  local name = bufname:match(("^.+%s(.+)$"):format(path_sep))
  local ext = name:match("^.+%.(.+)$") or ''
  local icon = require('nvim-web-devicons').get_icon(name, ext, {default = true})
  local ret = string.format(' %s %s ', icon, name)
  if c.read_only() then ret = ret .. icons.read_only .. ' ' end
  if c.buf_changed() then ret = ret .. icons.modified .. ' ' end
  return ret
end

M.get_pos = function()
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  local total = vim.fn.line('$')
  local percent = line * 100 / total
  if line == 1 then
    percent = 'TOP'
  elseif line == total then
    percent = 'END'
  else
    percent = string.format('%d%%', percent)
  end
  return string.format(' %s %d %s %d %s %s ',
    icons.line, line, icons.col, col, icons.percent, percent)
end

M.get_fileinfo = function()
  local filetype = require('plenary.filetype').detect(u.get_buf_name())
  local encoding = u.get_buf_option('fileencoding')
  return string.format(' %s %s %s ', icons.rabbit_face, filetype, encoding)
end

return M
