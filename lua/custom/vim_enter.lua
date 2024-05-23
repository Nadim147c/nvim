vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = vim.api.nvim_create_augroup("vim_enter_telescope_or_nvim_tree", { clear = true }),
    desc = "Highlight selection on yank",
    callback = function(data)
        if vim.fn.argv(0) == "" then
            require("telescope.builtin").find_files()
        end

        local directory = vim.fn.isdirectory(data.file) == 1

        if directory then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
            return
        end
    end,
})
