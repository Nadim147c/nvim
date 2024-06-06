vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = vim.api.nvim_create_augroup("vim_enter_telescope_or_nvim_tree", { clear = true }),
    desc = "Open telescope or nvim tree one vim enter",
    callback = function(data)
        if vim.fn.argv(0) == "" then
            local is_git = vim.fn.system { "git", "rev-parse", "--is-inside-work-tree" }
            if is_git == "true" then
                require("telescope.builtin").git_files()
            else
                require("telescope.builtin").find_files()
            end
        end

        local directory = vim.fn.isdirectory(data.file) == 1

        if directory then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
            return
        end
    end,
})
