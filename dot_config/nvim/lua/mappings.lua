local M = {}
local u = require('utils')

-- push parameters to list and defer mapping
local paras_tbl = {}
local function map(mode, lhs, rhs, opts)
  table.insert(paras_tbl, {mode, lhs, rhs, opts})
end

vim.g.mapleader = ' '
map('',  '<space>', '')

-- quit
map('',  'q',     '')
map('',  'Q',     '')
map('',  'qq',    [[<cmd>lua require('utils').close()<cr>]])
map('',  'qa',    '<cmd>qa<cr>')
map('',  '<m-q>', [[<cmd>lua require('utils').close()<cr>]])
map('i', '<m-q>', [[<cmd>lua require('utils').close()<cr>]])

-- save
map('',  '<m-w>', '<cmd>w<cr>')
map('i', '<m-w>', '<esc>:w<cr>')

-- start new line
map('i', '<m-o>', '<esc>o')
map('i', '<m-O>', '<esc>O')

-- insert empty line
map('i', '<m-i>', '<cmd>call append(".", "")<cr>')
map('n', '<m-i>', '<cmd>call append(".", "")<cr>')

-- end of line
map('', 'Y', 'yg_')
map('', 'L', 'g_')

-- window map
map('',  '<m-h>', '<c-w>h')
map('',  '<m-j>', '<c-w>j')
map('',  '<m-k>', '<c-w>k')
map('',  '<m-l>', '<esc><c-w>l')
-- map('i', '<m-h>', '<esc><c-w>h')
-- map('i', '<m-j>', '<esc><c-w>j')
-- map('i', '<m-k>', '<esc><c-w>k')
-- map('i', '<m-l>', '<esc><c-w>l')
map('t', '<m-h>', '<c-\\><c-n><c-w>h')
map('t', '<m-j>', '<c-\\><c-n><c-w>j')
map('t', '<m-k>', '<c-\\><c-n><c-w>k')
map('t', '<m-l>', '<c-\\><c-n><c-w>l')
map('',  '<m-,>', '3<c-w><')
map('',  '<m-.>', '3<c-w>>')
map('',  '<m-->', '3<c-w>-')
map('',  '<m-=>', '3<c-w>+')

-- insert move
map('i', '<c-a>', '<esc>I')
map('i', '<c-e>', '<esc>A')
map('i', '<c-h>', '<left>')
map('i', '<c-l>', '<right>')

-- normal move
map('', 'j', 'jzz<cmd>nohl<cr>')
map('', 'k', 'kzz<cmd>nohl<cr>')
map('', 'n', 'nzz')
map('', 'N', 'Nzz')

-- command line move
map('c', '<c-h>', '<left>')
map('c', '<c-l>', '<right>')
map('c', '<c-j>', '<down>')
map('c', '<c-k>', '<up>')
map('c', '<c-a>', '<home>')
map('c', '<c-e>', '<end>')
map('c', '<m-h>', '<c-left>')
map('c', '<m-l>', '<c-right>')
map('c', '<m-j>', '<down>')
map('c', '<m-k>', '<up>')

-- move cursor in previous window
map('',  '<m-u>', [[<cmd>lua require('utils').exe_prev('u')<cr>]])
map('i', '<m-u>', [[<cmd>lua require('utils').exe_prev('u')<cr>]])
map('',  '<m-d>', [[<cmd>lua require('utils').exe_prev('d')<cr>]])
map('i', '<m-d>', [[<cmd>lua require('utils').exe_prev('d')<cr>]])
map('',  '<m-s>', [[<cmd>lua require('utils').exe_prev('s')<cr>]])
map('i', '<m-s>', [[<cmd>lua require('utils').exe_prev('s')<cr>]])

-- indent
map('n', '>', '>>')
map('n', '<', '<<')

-- Delimate
-- map('i', '<cr>', '<c-r>=AutoPairsReturn()<cr>')

-- EasyAlign
map('v', '<enter>', '<Plug>(EasyAlign)', {noremap = false})
map('n', 'ga',      '<Plug>(EasyAlign)', {noremap = false})

-- sneak
map('', 'e', '<Plug>Sneak_s', {noremap = false})
map('', 'E', '<Plug>Sneak_S', {noremap = false})

-- nerdcommenter
map('', '<m-/>', '<Plug>NERDCommenterToggle', {noremap = false})

-- tab
map('', '<tab>',  '')
map('', '<tab>j', [[<cmd>lua require('rabbitline.tabline').tab_move_right()<cr>]])
map('', '<tab>k', [[<cmd>lua require('rabbitline.tabline').tab_move_left()<cr>]])
map('', '<tab>l', '<cmd>tabn<cr>')
map('', '<tab>h', '<cmd>tabp<cr>')
map('', '<tab>c', '<cmd>tabnew<cr>')
for i=0,9 do
  map('', '<tab>' .. i, ([[<cmd>lua require('rabbitline.tabline').move(%d)<cr>]]):format(i))
  map('', ('<m-%d>'):format(i), ('<cmd>%dtabn<cr>'):format(i or 10))
end
-- tabline

-- neogen
map('i', '<m-h>', [[<cmd>lua require('neogen').jump_prev()<cr>]])
map('i', '<m-l>', [[<cmd>lua require('neogen').jump_next()<cr>]])
map('n', '<m-k>', [[<cmd>lua require('neogen').generate()<cr>]])

-- telescope
map('', '<m-p>',      [[<cmd>lua require('telescope.builtin').builtin()<cr>]])
map('', '<leader>fm', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
map('', '<leader>ft', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]])
map('', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
map('', '-',          [[<cmd>lua require('plug.telescope.adapter').file_browser()<cr><esc>]])
map('', '<leader>ff', [[<cmd>lua require('plug.telescope.adapter').find_file()<cr>]])
map('', '<leader>fe', [[<cmd>lua require('plug.telescope.adapter').emoji()<cr>]])
map('', '<leader>fl', [[<cmd>lua require('plug.telescope.adapter').find_line()<cr>]])
map('', '<leader>gr', [[<cmd>lua require('plug.telescope.adapter').live_grep_root()<cr>]])
map('', '<leader>gc', [[<cmd>lua require('plug.telescope.adapter').live_grep_current()<cr>]])
map('', '<leader>go', [[<cmd>lua require('plug.telescope.adapter').live_grep_opened()<cr>]])
map('', '<leader>cr', [[<cmd>lua require('plug.telescope.adapter').references()<cr>]])
map('', '<leader>cd', [[<cmd>lua require('plug.telescope.adapter').definitions()<cr>]])

-- coc
map('',  '<c-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"]],                 {expr = true})
map('',  '<c-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"]],                 {expr = true})
map('i', '<c-f>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]], {expr = true})
map('i', '<c-b>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]],  {expr = true})

map('n', '[d', '<Plug>(coc-diagnostic-prev)')
map('n', ']d', '<Plug>(coc-diagnostic-next)')
map('n', 'gd', [[<Cmd>lua require('plug.coc').go2def()<cr>]])
map('n', 'gy', '<Plug>(coc-type-definition)')
map('n', 'gi', '<Plug>(coc-implementation)')
map('n', 'gr', '<Plug>(coc-references-used)')
map('n', 'K',  [[<Cmd>lua require('plug.coc').show_documentation()<cr>]])

map('n', '<Leader>rn', [[<Cmd>lua require('plug.coc').rename()<cr>]])
map('n', '<Leader>ac', [[<Cmd>lua require('plug.coc').code_action('')<cr>]])
map('n', '<m-cr>',     [[<Cmd>lua require('plug.coc').code_action('line')<cr>]])
map('x', '<m-cr>',     [[:<c-u>lua require('plug.coc').code_action(vim.fn.visualmode())<cr>]])

map('i', '<tab>', [[pumvisible() ? "\<c-n>" : "\<tab>"]], {expr = true})
map('i', '<c-k>', [[pumvisible() ? "\<c-p>" : "\<tab>"]], {expr = true})

M.paras_tbl = paras_tbl

return M
