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
            "folke/neodev.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require "configs.lsp.configs"
        end,
    },
}
