return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip").setup()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "saghen/blink.cmp",
    lazy = false,
    version = "v0.11",
    dependencies = "L3MON4D3/LuaSnip",
    config = function()
      local cmp = require "blink.cmp"
      cmp.setup {
        keymap = {
          ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "select_and_accept", "fallback" },

          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },

          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
          cmdline = {
            ["<Up>"] = {
              function()
                cmp.select_prev { auto_insert = true }
              end,
              "fallback",
            },
            ["<C-p>"] = {
              function()
                cmp.select_prev { auto_insert = true }
              end,
              "fallback",
            },
            ["<Down>"] = {
              function()
                cmp.select_next { auto_insert = true }
              end,
              "fallback",
            },
            ["<C-n>"] = {
              function()
                cmp.select_next { auto_insert = true }
              end,
              "fallback",
            },
          },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },
        snippets = { preset = "luasnip" },
        completion = {
          accept = { auto_brackets = { enabled = false } },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
            window = {
              border = "rounded",
            },
          },
          menu = {
            border = "rounded",
          },
        },

        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            buffer = { min_keyword_length = 2 },
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
      }
    end,
  },
}
