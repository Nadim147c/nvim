return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        ---@param key string
        ---@param func function
        ---@param desc string
        local function map(key, func, desc)
            vim.keymap.set("n", "<leader>f" .. key, func, { desc = "Telescope " .. desc })
        end

        local builtins = require "telescope.builtin"

        --- File & Buffer Search
        map("c", builtins.find_files { cwd = vim.fn.stdpath "config" }, "find config files")
        map("a", builtins.find_files { follow = true, no_ignore = true, hidden = true }, "find all files")
        map("f", builtins.find_files, "find files")
        map("o", builtins.oldfiles, "find recently opened files")
        map("b", builtins.buffers, "find opened buffers")

        -- Content Search
        map("w", builtins.live_grep, "live grep")
        map("z", builtins.current_buffer_fuzzy_find, "find in current buffer")

        -- GIT Search
        map("gc", builtins.git_commits, "git commits")
        map("gb", builtins.git_branches, "git branch")
        map("gf", builtins.git_files, "git files")

        -- Random
        map("h", builtins.help_tags, "help page")

        require("telescope").load_extension "ui-select"
        require("telescope").load_extension "fzf"

        require("telescope").setup {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                },
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown {} },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        }
    end,
}
