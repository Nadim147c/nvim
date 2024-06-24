vim.filetype.add {
    pattern = {
        [".*/kitty/.+%.conf"] = "bash",
    },
    filename = {
        [".prettierrc"] = "yaml",
    },
}
