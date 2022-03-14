local M   = {}
local cmd = vim.cmd
local fmt = string.format

local colors = require('line.colors')
local pu     = require('line.providers.utils')
local icons  = require('rabbitline.icons')
local c      = require('rabbitline.conditions')
local p      = require('rabbitline.providers')

local mode = function()
  return p.mode_mode[vim.fn.mode()]
end

local bubble_hl = function()
  local _mode = mode()
  local hl_group = 'StlModeSep' .. _mode
  cmd(fmt('hi %s guifg=%s', hl_group, colors[_mode]))
  return hl_group
end

M.left = pu.left(bubble_hl, c.active)
M.right = pu.right(bubble_hl, c.active)

local mode_text = function()
  local winid = vim.g.statusline_winid
  local width = vim.api.nvim_win_get_width(winid)
  local mode_map = width > 120 and p.mode_map or p.mode_short_map
  return fmt('%s %s ', icons.rabbit, mode_map[vim.fn.mode()])
end

local mode_hl = function()
  local _mode = mode()
  local hl_group = 'StlMode' .. _mode
  cmd(fmt('hi %s guibg=%s guifg=%s gui=bold', hl_group, colors[_mode], colors.mode_fg))
  return hl_group
end

M.mode = {
  provider = mode_text,
  highlight = mode_hl,
  condition = c.active
}

return M
