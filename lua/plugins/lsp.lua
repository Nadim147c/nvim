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
    config = function()
      local defaults = require "configs/lsp"
      vim.lsp.config("*", defaults)
    end,
  },
}
