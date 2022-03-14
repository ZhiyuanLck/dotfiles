local fn     = vim.fn
local cmd    = vim.cmd
local u      = require('plug.stl.utils')
local colors = require('plug.stl.colors').pos
local icons  = require('plug.stl.icons').pos

cmd(('hi GalaxyPos guifg=%s guibg=%s'):format(colors.fg, colors.bg))
cmd(('hi GalaxyPosBlank guifg=%s guibg=%s'):format(colors.bg, colors.bg))
cmd('hi GalaxyPosInv guifg=' .. colors.bg)

local function get_pos()
  local line = fn.line('.')
  local col = fn.col('.')
  local total = fn.line('$')
  local percent = line * 100 / total
  if line == 1 then
    percent = 'TOP'
  elseif line == total then
    percent = 'END'
  else
    percent = string.format('%d%%', percent)
  end
  return string.format('%s %d %s %d %s %s',
    icons.line, line, icons.col, col, icons.percent, percent)
end

local function pos()
  return {
    highlight = 'GalaxyPos',
    condition = u.buffer_not_empty,
    provider = function() return get_pos() end
  }
end

u.insert(3, u.bracket(1, 'GalaxyPosInv', u.buffer_not_empty))
u.insert(3, u.blank(1, 'GalaxyPosBlank', u.buffer_not_empty))
u.insert(3, pos())
u.insert(3, u.blank(1, 'GalaxyPosBlank', u.buffer_not_empty))
u.insert(3, u.bracket(2, 'GalaxyPosInv', u.buffer_not_empty))
