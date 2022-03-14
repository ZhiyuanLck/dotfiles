local M   = {}

local colors = require('line.colors')
local pu     = require('line.providers.utils')
local icons  = require('rabbitline.icons')
local c      = require('rabbitline.conditions')
local p      = require('rabbitline.providers')

local is_show = function()
  return c.active() and c.buf_not_empty()
end

M.left = pu.left(colors.info_bg, is_show)
M.right = pu.right(colors.info_bg, is_show)
M.fileinfo = {
  highlight = {colors.info_bg, colors.info_fg},
  provider = p.get_fileinfo,
  condition = is_show
}

return M
