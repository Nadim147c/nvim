return {
    "echasnovski/mini.files",
    event = "VeryLazy",
    version = "*",
    config = function()
        local files = require "mini.files"
        vim.keymap.set("n", "<C-n>", function() files.open() end, { desc = "Open mini.files" })

        files.setup {
            options = {
                permanent_delete = false,
                use_as_default_explorer = true,
            },
            mappings = {
                close = "q",
                go_in = "l",
                go_in_plus = "<CR>",
                go_out = "h",
                go_out_plus = "H",
                mark_goto = "'",
                mark_set = "m",
                reset = "<BS>",
                reveal_cwd = "@",
                show_help = "g?",
                synchronize = "=",
                trim_left = "<",
                trim_right = ">",
            },
            windows = {
                max_number = math.huge,
                preview = true,
                width_focus = 30,
                width_nofocus = 15,
                width_preview = 70,
            },
        }
    end,
}
