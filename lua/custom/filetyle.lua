local function zx_javascript(_, bufnr)
    ---@param str string
    local function trim(str)
        return (str:gsub("^%s*(.-)%s*$", "%1"))
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if vim.regex([[#!/usr/bin/\(env \)\?zx]]):match_str(line) then
            return "javascript"
        elseif string.len(trim(line)) ~= 0 then
            return
        end
    end
end

vim.filetype.add {
    pattern = {
        [".*"] = zx_javascript,
    },
    filename = {
        [".prettierrc"] = "yaml",
    },
}
