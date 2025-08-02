return {
  { "b0o/schemastore.nvim", version = false },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "~/git/chroma.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local defaults = require "configs/lsp"
      vim.lsp.config("*", defaults)

      vim.lsp.config("qmlls", { cmd = { "qmlls6", "-E" } })
      vim.lsp.enable "qmlls"
      vim.lsp.enable "nixd"
    end,
  },
}
