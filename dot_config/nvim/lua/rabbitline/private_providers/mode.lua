local M = {}

M.mode_mode = {
  n        = 'normal',
  niI      = 'normal',
  niR      = 'normal',
  niV      = 'normal',
  nt       = 'normal',
  no       = 'pending',
  nov      = 'pending',
  noV      = 'pending',
  ['no'] = 'pending',
  v        = 'visual',
  vs       = 'visual',
  V        = 'visuall',
  Vs       = 'visuall',
  ['']   = 'visualb',
  ['s']  = 'visualb',
  s        = 'selection',
  S        = 'selection',
  ['']   = 'selection',
  i        = 'insert',
  ic       = 'insert',
  ix       = 'insert',
  R        = 'replace',
  Rc       = 'replace',
  Rx       = 'replace',
  Rv       = 'replace',
  Rvc      = 'replace',
  Rvx      = 'replace',
  r        = 'replace',
  rm       = 'replace',
  ['r?']   = 'replace',
  c        = 'command',
  cv       = 'command',
  t        = 'terminal',
  ['!']    = 'shell',
}

M.mode_map = {
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

M.mode_short_map = {
  n        = 'N',
  niI      = '(N)',
  niR      = '(N)',
  niV      = '(N)',
  nt       = 'N',
  no       = 'N..',
  nov      = 'N..',
  noV      = 'N..',
  ['no'] = 'N..',
  v        = 'V',
  vs       = '(V)',
  V        = 'VL',
  Vs       = '(VL)',
  ['']   = 'VB',
  ['s']  = '(VB)',
  s        = 'S',
  S        = 'SL',
  ['']   = 'SB',
  i        = 'I',
  ic       = 'IC',
  ix       = '(IC)',
  R        = 'R',
  Rc       = 'RC',
  Rx       = '(RC)',
  Rv       = 'VR',
  Rvc      = 'VRC',
  Rvx      = '(VRC)',
  r        = 'I',
  rm       = 'I..',
  ['r?']   = 'Q',
  c        = 'C',
  cv       = 'C',
  t        = 'T',
  ['!']    = 'S..',
}

return M
