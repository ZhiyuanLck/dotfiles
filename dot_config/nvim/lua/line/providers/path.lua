local M = {}
local fmt = string.format

local colors = require('line.colors')
local icons  = require('line.icons')
local pu     = require('line.providers.utils')

local c        = require('rabbitline.conditions')
local get_path = require('rabbitline.providers').get_path

local bubble_hl = function()
  local fg = c.active() and colors.path_active_bg or colors.path_inactive_bg
  vim.cmd('hi StlPathLeft guifg=' .. fg)
  return 'StlPathLeft'
end

M.left = pu.left(bubble_hl, c.buf_not_empty)
M.right = pu.right(bubble_hl, c.buf_not_empty)

local path_hl = function()
  local bg, fg
  if c.active() then
    bg = colors.path_active_bg
    fg = c.buf_changed() and colors.path_active_changed or colors.path_active_fg
  else
    bg = colors.path_inactive_bg
    fg = c.buf_changed() and colors.path_inactive_changed or colors.path_active_fg
  end
  vim.cmd(fmt('hi StlPath guibg=%s guifg=%s', bg, fg))
  return 'StlPath'
end

M.path = {
  highlight = path_hl,
  provider  = get_path,
  condition = c.buf_not_empty,
}

return M
