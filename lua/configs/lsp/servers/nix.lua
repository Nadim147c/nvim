local lsp_defaults = require "configs.lsp.defaults"
local lspconfig = require "lspconfig"

lspconfig.nixd.setup {
  capabilities = lsp_defaults.capabilities,
  on_init = lsp_defaults.on_init,
  on_attach = lsp_defaults.on_attach,
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
      },
      options = {
        home_manager = {
          expr = '(builtins.getFlake "/home/ephemeral/git/dotfiles").homeConfigurations.ephemeral.options',
        },
      },
    },
  },
}

return {}
