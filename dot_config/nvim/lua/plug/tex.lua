local g = vim.g

g.tex_flavor = 'latex'
g.vimtex_view_general_viewer = 'SumatraPDF.exe'
g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
g.vimtex_quickfix_mode = 2
g.vimtex_indent_on_ampersands = 0
g.vimtex_quickfix_autoclose_after_keystrokes = 2
g.vimtex_quickfix_ignore_filters = {
  'Warning.*Fandol', 'Overfull', 'Underfull',
  'Warning.*Font', 'Warning.*font'
}

g.vimtex_compiler_latexmk_engines = {
  ['_'] = '-xelatex --shell-escape',
  pdflatex = '-pdf --shell-escape',
  xelatex = '-xelatex --shell-escape',
  lualatex = '-lualatex --shell-escape'
}
