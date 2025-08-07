return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    dependencies = "xiyaowong/transparent.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme "catppuccin-mocha"
      local transparent = require "transparent"
      transparent.clear_prefix "lualine"
      transparent.clear_prefix "SnacksPicker"
      transparent.clear_prefix "StatusLine"
    end,
    opts = {
      custom_highlights = function(colors)
        return {
          HighlightUrl = { fg = colors.blue },
          Winbar = { fg = colors.sky },
          WinbarSeparator = { fg = colors.red },
          WinbarDir = { fg = colors.blue },
        }
      end,
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = { enabled = false },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      local transparent = require "transparent"
      transparent.setup {
        extra_groups = {
          "NormalFloat",
          "FloatBorder",
          "NvimTreeNormal",
          "MiniFilesBorder",
          "MiniFilesBorderModified",
          "MiniFilesTitleFocused",
          "MiniFilesTitle",
          "MiniStatuslineDevinfo",
          "MiniStatuslineInactive",
          "MiniStatuslineFilename",
          "MiniStatuslineFileinfo",
          "MiniStatuslineModeOther",
        },
      }
    end,
  },
}
