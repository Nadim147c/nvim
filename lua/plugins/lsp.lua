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
    "Massolari/lsp-auto-setup.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local config = require "configs.lsp"

      local lspconfig = require "lspconfig"
      lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, config)
      vim.lsp.config("*", config)

      require("lsp-auto-setup").setup {}
    end,
  },
}
