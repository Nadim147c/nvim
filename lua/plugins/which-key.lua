return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        function whick_lookup() vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ") end
        vim.keymap.set("n", "<leader>wk", whick_lookup, { desc = "whichkey query lookup" })
        vim.keymap.set("n", "<leader>wK", "<CMD> WhichKey <CR>", { desc = "whichkey all keymaps" })

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
}
