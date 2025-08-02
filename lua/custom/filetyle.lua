vim.filetype.add {
  extension = {
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
  },
  pattern = {
    [".*/kitty/.+%.conf"] = "bash",
    [".*/hypr/.+%.conf"] = "hyprlang",
    [".*/waybar/config"] = "jsonc",
    [".*/ghostty/config"] = "ini",
    [".*/fontconfig/font.conf"] = "xml",
    [".*/uwsm/env.*"] = "sh",
    [".*/.gitconfig.*"] = "gitconfig",
    [".*/.?config/git/.*"] = "gitconfig",
  },
  filename = {
    [".prettierrc"] = "yaml",
  },
}
