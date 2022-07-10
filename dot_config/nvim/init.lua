require('options')
require('commands')
require('plug.theme')
vim.cmd('pa vim-diary')
vim.cmd('pa nvim-web-devicons')
vim.cmd('pa plenary.nvim')
-- require('plug.stl')
require('line')
require('lazy')

vim.cmd([[
  aug Diary
    au!
    au BufRead,BufNew *.dr nnoremap <buffer><silent> gf vip:s/\n/\r\r/g<cr>gvgqkdd
  aug END
]])
