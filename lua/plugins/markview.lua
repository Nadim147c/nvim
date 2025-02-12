return {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    cmd = "Markview",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.icons",
    },
    config = function()
        vim.keymap.set("n", "<leader>m", "<CMD> Markview toggle <CR>", { desc = "Toggle markview" })

        require("markview").setup {
            preview = { icon_provider = "mini" },
        }
    end,
}
