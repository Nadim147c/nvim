return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        -- File search
        { "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" } },
        {
            "<leader>fa",
            "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
            desc = "Telescope find all files",
        },

        -- Content Search
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Telescope find oldfiles" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope find buffers" },
        { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
        { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope find in current buffer" },

        -- Random/IDK
        { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope help page" },
        { "<leader>fta", "<cmd>Telescope marks<CR>", desc = "Telescope find marks" },

        -- Git
        { "<leader>fgc", "<cmd>Telescope git_commits<CR>", desc = "Telescope git commits" },
        { "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Telescope git status" },
    },
    config = function()
        require("telescope").load_extension "ui-select"

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
            extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown {} } },
        }
    end,
}
