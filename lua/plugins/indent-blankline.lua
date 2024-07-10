return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
        local hooks = require "ibl.hooks"

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        -- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

        local highlight = {
            "IndentRed",
            "IndentYellow",
            "IndentBlue",
            "IndentOrange",
            "IndentGreen",
            "IndentViolet",
            "IndentCyan",
        }

        local colors = require("catppuccin.palettes").get_palette "mocha"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentRed", { fg = colors.red })
            vim.api.nvim_set_hl(0, "IndentYellow", { fg = colors.yellow })
            vim.api.nvim_set_hl(0, "IndentBlue", { fg = colors.blue })
            vim.api.nvim_set_hl(0, "IndentOrange", { fg = colors.maroon })
            vim.api.nvim_set_hl(0, "IndentGreen", { fg = colors.green })
            vim.api.nvim_set_hl(0, "IndentViolet", { fg = colors.pink })
            vim.api.nvim_set_hl(0, "IndentCyan", { fg = colors.sky })
        end)

        require("ibl").setup { indent = { highlight = highlight } }
    end,
}
