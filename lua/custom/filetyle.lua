vim.filetype.add {
    pattern = {
        [".*/kitty/.+%.conf"] = "bash",
        [".*/fontconfig/font.conf"] = "xml",
    },
    filename = {
        [".prettierrc"] = "yaml",
    },
}
