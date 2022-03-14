local fn = vim.fn
local env, g, o = vim.env, vim.g, vim.o

-- show
o.number        = true
o.cursorline    = true
o.cursorlineopt = 'number,screenline'
o.signcolumn    = 'yes:1'
o.list          = true
o.listchars     = 'tab:▏ ,trail:•,precedes:<,extends:>'
o.sidescrolloff = 5
o.showbreak     = '╰─➤ '
o.showmode      = false
o.wrap          = true
o.cpoptions     = o.cpoptions .. 'n'
o.title         = true
o.titlestring   = '%(%m%)%(%{expand(\"%:~\")}%)'
o.lazyredraw    = true
o.shortmess     = o.shortmess .. 'acsIS'
o.confirm       = true
o.diffopt       = o.diffopt .. ',vertical,internal,algorithm:patience'
o.termguicolors = true
o.fillchars     = 'eob: '
o.pumblend      = 8
o.synmaxcol     = 300

-- format
o.formatoptions = o.formatoptions .. 'mB'

-- tab and indent
o.tabstop     = 2
o.shiftwidth  = 2
o.expandtab   = true
o.smartindent = true

-- ignorecase when only lower cases
o.ignorecase = true
o.smartcase  = true

-- other
o.updatetime    = 200
o.cedit         = '<c-x>'
o.fileencodings = 'utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1'
o.jumpoptions   = 'stack'
o.shada         = [['20,<50,s10,/20,@20,:20,h]]
o.autoread      = true
o.autochdir     = true
o.mouse         = 'a'

-- undo
o.undofile   = true
o.undolevels = 1000

-- no backup
o.backup   = false
o.swapfile = false

-- clipboard
o.clipboard = 'unnamedplus'

local clipboard
-- need win32yank.exe https://github.com/equalsraf/win32yank
if fn.executable('win32yank.exe') == 1 then
  clipboard = {
    name = 'wsl',
    copy = {
      ['+'] = {'win32yank.exe', '-i'},
      ['*'] = {'win32yank.exe', '-i'}
    },
    paste = {
      ['+'] = {'win32yank.exe', '-o'},
      ['*'] = {'win32yank.exe', '-o'}
    },
    cache_enabled = false
  }
elseif env.DISPLAY and fn.executable('xsel') == 1 then
  clipboard = {
    name = 'xsel',
    copy = {
      ['+'] = {'xsel', '--nodetach', '-i', '-b'},
      ['*'] = {'xsel', '--nodetach', '-i', '-p'}
    },
    paste = {['+'] = {'xsel', '-o', '-b'}, ['*'] = {'xsel', '-o', '-p'}},
    cache_enabled = true
  }
elseif env.TMUX then
  clipboard = {
    name  = 'tmux',
    copy  = {['+'] = {'tmux', 'load-buffer', '-'}},
    paste = {['+'] = {'tmux', 'save-buffer', '-'}},
    cache_enabled = true
  }
  clipboard.copy['*']  = clipboard.copy['+']
  clipboard.paste['*'] = clipboard.paste['+']
elseif fn.executable('osc52send') == 1 then
  clipboard = {
    name  = 'osc52send',
    copy  = {['+'] = {'osc52send'}},
    paste = {
      ['+'] = function()
        return {fn.getreg('0', 1, true), fn.getregtype('0')}
      end
    },
    cache_enabled = false
  }
  clipboard.copy['*']  = clipboard.copy['+']
  clipboard.paste['*'] = clipboard.paste['+']
end

g.clipboard = clipboard

-- NERDCommenter
g.NERDCreateDefaultMappings  = 0
g.NERDSpaceDelims            = 1
g.NERDCompactSexyComs        = 1
g.NERDDefaultAlign           = 'left'
g.NERDToggleCheckAllLines    = 1
g.NERDTrimTrailingWhitespace = 1
g.NERDAltDelims_c            = 1
g.NERDAltDelims_cpp          = 1
g.NERDCustomDelimiters       = {
  lua = {left = '--', leftAlt = '', rightAlt = ''},
  sty = {left = '%'}, cls = {left = '%'},
}

g.UltiSnipsNoPythonWarning = 1
g.UltiSnipsSnippetDirectories = {vim.fn.getenv('HOME') .. '/.config/nvim/snippet'}
g.UltiSnipsEditSplit = 'tabdo'
g.UltiSnipsExpandTrigger = '<c-j>'
g.UltiSnipsJumpForwardTrigger = '<c-j>'
g.UltiSnipsJumpBackwardTrigger = '<c-k>'

vim.cmd([[
  aug FT
    au!
    au FileType tex,markdown setl tw=100
  aug END
]])
