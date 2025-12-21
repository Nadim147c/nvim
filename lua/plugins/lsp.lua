return {
  { "b0o/schemastore.nvim", version = false },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local defaults = require "configs/lsp"
      vim.lsp.config("*", defaults)

      vim.lsp.enable {
        "qmlls",
        "nixd",
        "lua_ls",
        "gopls",
        "nushell",
        "nixd",
        "qmlls",
      }
    end,
  },
}
