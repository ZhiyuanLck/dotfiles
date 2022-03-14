vim.g.coq_settings = {
  -- manully load, remove hello
  -- auto_start = true,
  keymap = {
    recommended = false,
    pre_select = false,
    bigger_preview = '<c-k>',
    jump_to_mark = '<c-j>',
  },
}

require('utils').load({
  'nvim-lspconfig',
  'nvim-lsp-installer',
  'coq_nvim',
  'coq.artifacts',
  'coq.thirdparty',
})

local lsp = require('lspconfig')
local coq = require('coq')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {
  'clangd',
  'cmake',
  'jsonls',
  'texlab',
  'pyright',
  'sumneko_lua',
  'vimls',
}

local bmap = require('map.remap').bmap
local on_attach = function(client, bufnr)
  bmap(bufnr, '', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  bmap(bufnr, '', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  bmap(bufnr, '', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  bmap(bufnr, '', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  -- bmap(bufnr, '', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  bmap(bufnr, '', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  bmap(bufnr, '', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  bmap(bufnr, '', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  bmap(bufnr, '', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  bmap(bufnr, '', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  bmap(bufnr, '', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  bmap(bufnr, '', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  -- coq
  bmap(bufnr, 'i', '<esc>', [[pumvisible() ? "\<c-e><esc>" : "\<esc>"]], {expr = true})
  bmap(bufnr, 'i', '<cr>',
    [[pumvisible() ? (complete_info().selected == -1 ? "\<c-e><CR>" : "\<c-y>") : "\<cr>"]],
    {expr = true})
  bmap(bufnr, 'i', '<m-j>', [[pumvisible() ? "\<C-n>" : "\<esc><c-w>j"]], {expr = true})
  bmap(bufnr, 'i', '<m-k>', [[pumvisible() ? "\<C-p>" : "\<esc><c-w>k"]], {expr = true})
end

for _, server_name in pairs(servers) do
  local server_available, server = lsp_installer_servers.get_server(server_name)
  if server_available then
    local opts = {
      on_attach = on_attach,
    }
    server:on_ready(function()
      lsp[server_name].setup(coq.lsp_ensure_capabilities(opts))
    end)
    if not server:is_installed() then
      -- Queue the server to be installed.
      server:install()
    end
    lsp[server_name].setup(coq.lsp_ensure_capabilities(opts))
  end
end

require("coq_3p") {
  { src = 'nvimlua', short_name = 'nLUA', conf_only = true },
  { src = "vimtex", short_name = "vTEX" }
}

vim.cmd('COQnow -s')
