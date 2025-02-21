local lsp_defaults = require "configs.lsp.defaults"
local lspconfig = require "lspconfig"

lspconfig.nushell.setup {
  capabilities = lsp_defaults.capabilities,
  on_init = lsp_defaults.on_init,
  on_attach = lsp_defaults.on_attach,
  cmd = { "nu", "--lsp" },
  settings = {
    formatting = {
      command = { "nufmt" },
    },
  },
}

return {}
