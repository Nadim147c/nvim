return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function(_, opts)
            require("nvim-tree").setup(opts)
            vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree toggle window" })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require "configs.lualine"
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup {}
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            "smjonas/inc-rename.nvim",
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("notify").setup { background_colour = "#000000" }
            require("inc_rename").setup {}

            require("noice").setup {
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },

                presets = {
                    bottom_search = false,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
            }
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            vim.keymap.set("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
            vim.keymap.set("n", "<leader>wk", function()
                vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
            end, { desc = "whichkey query lookup" })
            local wk = require "which-key"
            wk.register({}, {
                mode = "n",
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
                expr = false,
            })
        end,
    },
}
