return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                lazy = false,
                config = true,
                opts = function()
                    return require "configs.mason"
                end,
            },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require "configs.lsp.configs"
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = "Bilal2453/luvit-meta",
        opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
    },
    {
        "b0o/schemastore.nvim",
        version = false,
    },
}
