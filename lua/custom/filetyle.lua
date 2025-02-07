vim.filetype.add {
    pattern = {
        [".*/kitty/.+%.conf"] = "bash",
        [".*/hypr/.+%.conf"] = "hyprlang",
        [".*/waybar/config"] = "jsonc",
        [".*/fontconfig/font.conf"] = "xml",
        [".*/uwsm/env.*"] = "sh",
    },
    filename = {
        [".prettierrc"] = "yaml",
    },
}
