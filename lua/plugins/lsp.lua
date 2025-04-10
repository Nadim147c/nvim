return {
  { "b0o/schemastore.nvim", version = false },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
    opts = {
      max_concurrent_installers = 10,
      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " ",
        },
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
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
