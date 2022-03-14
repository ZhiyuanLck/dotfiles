-- https://github.com/folke/tokyonight.nvim
vim.cmd('pa tokyonight.nvim')
vim.o.background = 'dark'
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd('colorscheme tokyonight')
