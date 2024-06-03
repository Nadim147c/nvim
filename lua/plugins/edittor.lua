return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            prefer_git = true,
            ensure_installed = { "lua" },
            indent = {
                enable = true,
                disable = { "python" },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "numToStr/Comment.nvim",
        init = function()
            vim.keymap.set("n", "<leader>/", function()
                require("Comment.api").toggle.linewise.current()
            end, { desc = "Comment toggle" })

            vim.keymap.set(
                "v",
                "<leader>/",
                "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
                { desc = "Comment toggle" }
            )
        end,
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {}
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    {
        "Wansmer/treesj",
        keys = {
            { "<leader>tm", "<CMD> TSJToggle <CR>", desc = "Toggle node splitting" },
            { "<leader>ts", "<cmd> tsjsplit <cr>", desc = "split node under cursor" },
            { "<leader>tj", "<CMD> TSJJoin <CR>", desc = "Join node under cursor" },
        },
        cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("treesj").setup { use_default_keymaps = false }
        end,
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        cmd = "TroubleToggle",
        keys = { { "<leader>tt", "<cmd> TroubleToggle <CR>", desc = "Toggle trouble window" } },
    },
}
