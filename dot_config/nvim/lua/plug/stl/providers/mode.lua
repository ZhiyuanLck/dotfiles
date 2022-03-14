local fn     = vim.fn
local cmd    = vim.cmd
local u      = require('plug.stl.utils')
local colors = require('plug.stl.colors').mode
local icons  = require('plug.stl.icons').mode

-- Return bg color of mode
-- @param m string
-- @return string of hex color
local function mode_color()
  local mode_colors = {
    n        = colors.normal,
    niI      = colors.normal,
    niR      = colors.normal,
    niV      = colors.normal,
    nt       = colors.normal,
    no       = colors.pending,
    nov      = colors.pending,
    noV      = colors.pending,
    ['no'] = colors.pending,
    v        = colors.visual,
    vs       = colors.visual,
    V        = colors.visual,
    Vs       = colors.visual,
    ['']   = colors.visual,
    ['s']  = colors.visual,
    s        = colors.selection,
    S        = colors.selection,
    ['']   = colors.selection,
    i        = colors.insert,
    ic       = colors.insert,
    ix       = colors.insert,
    R        = colors.replace,
    Rc       = colors.replace,
    Rx       = colors.replace,
    Rv       = colors.replace,
    Rvc      = colors.replace,
    Rvx      = colors.replace,
    r        = colors.replace,
    rm       = colors.replace,
    ['r?']   = colors.replace,
    c        = colors.command,
    cv       = colors.command,
    t        = colors.terminal,
    ['!']    = colors.shell,
  }
  return mode_colors[fn.mode()]
end

-- Return text of mode
-- @param m string
-- @return string of text
local function mode_text(m)
  local mode_texts = {
    n        = 'NORMAL',
    niI      = '(NORMAL)',
    niR      = '(NORMAL)',
    niV      = '(NORMAL)',
    nt       = 'NORMAL',
    no       = 'NORMAL..',
    nov      = 'NORMAL..',
    noV      = 'NORMAL..',
    ['no'] = 'NORMAL..',
    v        = 'VISUAL',
    vs       = '(VISUAL)',
    V        = 'VISUAL LINE',
    Vs       = '(VISUAL LINE)',
    ['']   = 'VISUAL BLOCK',
    ['s']  = '(VISUAL BLOCK)',
    s        = 'SELECT',
    S        = 'SELECT LINE',
    ['']   = 'SELECT BLOCK',
    i        = 'INSERT',
    ic       = 'I COMP',
    ix       = '(I COMP)',
    R        = 'REPLACE',
    Rc       = 'R COMP',
    Rx       = '(R COMP)',
    Rv       = 'VISUAL REPLACE',
    Rvc      = 'VR COMP',
    Rvx      = '(VR COMP)',
    r        = 'INFO',
    rm       = 'INFO..',
    ['r?']   = 'QUERY',
    c        = 'COMMAND',
    cv       = 'COMMAND',
    t        = 'TERMINAL',
    ['!']    = 'SHELL RUNNING...',
  }
  return mode_texts[fn.mode()]
end

-- set highlights
local function set_mode()
  local c = mode_color()
  cmd(('hi GalaxyMode guibg=%s guifg=%s gui=bold'):format(c, colors.text))
  cmd(('hi GalaxyModeBlank guibg=%s guifg=%s'):format(c, c))
  cmd(('hi GalaxyModeInvR guibg=%s guifg=%s'):format(c, colors.file_bg))
  cmd('hi GalaxyModeInvL guifg=' .. c)
end

-- mode provider
local function mode()
  return {
    highlight = 'GalaxyMode',
    provider  = function()
      set_mode()
      return icons.rabbit .. ' ' .. mode_text()
    end,
  }
end

u.insert(1, u.bracket(1, 'GalaxyModeInvL'))
u.insert(1, mode())
u.insert(1, u.blank(1, 'GalaxyModeBlank'))
u.insert(1, u.bracket(2, 'GalaxyModeInvL', u.buffer_empty))
