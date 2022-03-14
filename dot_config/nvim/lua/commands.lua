-- packer
local conf_dir = vim.fn.stdpath('config')
if vim.loop.fs_stat(conf_dir .. '/plugin/packer_compiled.lua') then
  vim.cmd([[
    com! PackerInstall lua require('plug.packer').install()
    com! PackerUpdate lua require('plug.packer').update()
    com! PackerSync lua require('plug.packer').sync()
    com! PackerClean lua require('plug.packer').clean()
    com! PackerStatus lua require('plug.packer').status()
    com! -nargs=? PackerCompile lua require('plug.packer').compile(<q-args>)
    com! -nargs=+ PackerLoad lua require('plug.packer').loader(<q-args>)
  ]])
else
  require('plug.packer').compile()
end
