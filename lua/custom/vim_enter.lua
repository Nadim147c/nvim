vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = vim.api.nvim_create_augroup("vim_enter_file_picker", { clear = true }),
    desc = "Open snacks picker or nvim tree one vim enter",
    callback = function(data)
        if vim.fn.argv(0) == "" then
            Snacks.picker.pick("files", {
                cmd = "rg",
                args = { "--files", "--hidden", "--color=never", "--glob=!.git" },
            })
        end

        local directory = vim.fn.isdirectory(data.file) == 1

        if directory then
            vim.cmd.cd(data.file)
            return
        end
    end,
})
