return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    dependencies = "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,
    config = true,
    opts = {
      styles = {
        transparency = true,
      },
      extend_background_behind_borders = true,
    },
    init = function()
      require("transparent").clear_prefix "lualine"
    end,
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      local transparent = require "transparent"
      transparent.setup { extra_groups = { "NormalFloat", "NvimTreeNormal" } }
      transparent.clear_prefix "lualine"
      transparent.clear_prefix "fzf-lua"
      transparent.clear_prefix "nvim-tree"
    end,
  },
}
