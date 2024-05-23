local lualine = require "lualine"

local colors = require("catppuccin.palettes").get_palette "mocha"

local config = {
    options = {
        component_separators = "|",
        section_separators = "",
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}

local function insert_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function insert_right(component)
    table.insert(config.sections.lualine_x, component)
end

insert_left {
    "branch",
    icon = "",
    color = { fg = colors.red, gui = "bold" },
}

insert_left {
    "o:encoding",
    color = { fg = colors.green, gui = "bold" },
}

insert_left {
    "fileformat",
    icons_enabled = true,
    color = { fg = colors.yellow, gui = "bold" },
}

insert_left {
    "diff",
    symbols = { added = " ", modified = "󰝤 ", removed = " " },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.mauve },
        removed = { fg = colors.red },
    },
}

insert_left {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {},
}

insert_right {
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " LSP :",
    color = { fg = colors.green, gui = "bold" },
}

insert_right {
    "filename",
    color = { fg = colors.teal, gui = "bold" },
}

insert_right {
    "location",
    color = { fg = colors.pink },
}

insert_right {
    "progress",
    color = { fg = colors.text, gui = "bold" },
}

lualine.setup(config)
