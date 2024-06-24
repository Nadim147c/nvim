return {
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        config = function(_, opts)
            local crates = require "crates"
            crates.setup(opts)
            -- require("cmp").setup.buffer { sources = { { name = "crates" } } }
            crates.show()
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            vim.g.rustaceanvim = {
                server = require "configs.lsp.defaults",
            }
        end,
    },
}
