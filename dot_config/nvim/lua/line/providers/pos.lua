local M   = {}

local colors = require('line.colors')
local icons  = require('rabbitline.icons')
local c      = require('rabbitline.conditions')
local p      = require('rabbitline.providers')

M.left = {
  highlight = {nil, colors.pos_bg},
  provider = icons.left,
  condition = c.active,
}

M.right = {
  highlight = {nil, colors.pos_bg},
  provider = icons.right,
  condition = c.active,
}

M.pos = {
  highlight = {colors.pos_bg, colors.pos_fg},
  provider = p.get_pos,
  condition = c.active,
}

return M
