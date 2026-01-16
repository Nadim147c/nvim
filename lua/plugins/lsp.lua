return {
  { "b0o/schemastore.nvim", version = false },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local defaults = require "configs/lsp"
      vim.lsp.config("*", defaults)

      vim.lsp.enable {
        "cssls",
        "emmet_language_server",
        "gopls",
        "just",
        "lua_ls",
        "nixd",
        "nushell",
        "qmlls",
        "tailwindcss",
        "ts_ls",
        "tsgo",
      }
    end,
  },
}
