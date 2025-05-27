return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    auto_install = true,
    prefer_git = true,
    ensure_installed = { "lua", "gotag" },
    indent = {
      enable = true,
      disable = { "python" },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = true,
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.gotag = {
      install_info = {
        url = vim.fn.stdpath "config" .. "/treesitter/gotag",
        files = { "src/parser.c" },
        generate_requires_npm = false,
        requires_generate_from_grammar = true,
      },
    }
  end,
}
