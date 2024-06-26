return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
                flavor = "mocha",
                transparent_background = vim.g.transparent_enabled or false,
                term_colors = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true,
                    mini = { enabled = true, indentscope_color = "" },
                },
            }
        end,
    },

    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            local transparent = require "transparent"
            transparent.setup { extra_groups = { "NormalFloat", "NvimTreeNormal" } }
            transparent.clear_prefix "lualine"
            transparent.clear_prefix "nvim-tree"
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        config = function()
            require("nvim-tree").setup(require "configs.nvimtree")
            vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree toggle window" })
        end,
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local bufferline = require "bufferline"

            vim.keymap.set("n", "<leader>x", function()
                bufferline.unpin_and_close()
            end, { desc = "Close current buffer" })
            vim.keymap.set("n", "<tab>", function()
                bufferline.cycle(1)
            end, { desc = "Cycle on buffer list" })

            vim.keymap.set("n", "<s-tab>", function()
                bufferline.cycle(-1)
            end, { desc = "Cycle on buffer list" })

            bufferline.setup {
                options = {
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Nvim Tree",
                            highlight = "Directory",
                            text_align = "left",
                        },
                    },
                },
            }
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
            local notify = require "notify"
            ---@diagnostic disable-next-line: missing-fields
            notify.setup { background_colour = "#000000" }
            vim.keymap.set("n", "<leader>nd", notify.dismiss, { desc = "Dismiss all notifications" })

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
        "echasnovski/mini.hipatterns",
        event = "VeryLazy",
        desc = "Highlight colors in your code. Also includes Tailwind CSS support.",
        config = function()
            local hipatterns = require "mini.hipatterns"
            hipatterns.setup {
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
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
            vim.keymap.set("n", "<leader>wK", "<CMD> WhichKey <CR>", { desc = "whichkey all keymaps" })
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
