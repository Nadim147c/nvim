return {
  { "b0o/schemastore.nvim", version = false },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local defaults = require "configs/lsp"
      vim.lsp.config("*", defaults)

      vim.lsp.config("qmlls", { cmd = { "qmlls6", "-E" } })
      vim.lsp.enable "qmlls"
      vim.lsp.enable "nixd"
      vim.lsp.enable "lua_ls"
    end,
  },
}
