local M = {}

local file_bg = '#dde2ec'

M.mode = {
  text       = '#000000',
  main       = '#ff87ff',
  normal     = '#e3939b',
  pending    = '#909481',
  insert     = '#89d99c',
  command    = '#e58605',
  visual     = '#8cabc8',
  visualb    = '#9c7354',
  select     = '#ff92ff',
  replace    = '#ff5757',
  terminal   = '#c678dd',
  shell      = '#990000',
  file_bg    = file_bg,
}

M.file_path = {
  file_bg    = file_bg,
  active     = '#282c34',
  inactive   = '#5C5C81',
  active_m   = '#ff0000',
  inactive_m = '#cc8800',
}

M.pos = {
  bg = '#444952',
  fg = '#dde2ec',
}

return M
