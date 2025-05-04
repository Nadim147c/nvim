-- Utility function to get highlight colors
local function get_hl_color(name, attr)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  if not hl then
    return nil
  end

  if attr == "fg" and hl.fg then
    return string.format("#%06x", hl.fg)
  elseif attr == "bg" and hl.bg then
    return string.format("#%06x", hl.bg)
  end
  return nil
end

---@param check boolean
local function lsp_name(check)
  local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then
    return
  end
  for _, client in ipairs(clients) do
    ---@type string[]
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      if check == true then
        return true
      end
      return client.name
    end
  end
  return false
end

---@param check boolean
local function macro_recording(check)
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return
  end
  if check == true then
    return true
  end
  return "Recording to [" .. reg .. "]"
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "arkav/lualine-lsp-progress",
    { "ThePrimeagen/harpoon", branch = "harpoon2" },
    "letieu/harpoon-lualine",
  },
  lazy = false,
  config = function()
    local lualine = require "lualine"

    -- Direct reference to highlight groups
    local highlights = {
      statement = get_hl_color("Statement", "fg"),
      error = get_hl_color("DiagnosticError", "fg"),
      warn = get_hl_color("DiagnosticWarn", "fg"),
      string = get_hl_color("String", "fg"),
      special = get_hl_color("Special", "fg"),
      ident = get_hl_color("Identifier", "fg"),
      func = get_hl_color("Function", "fg"),
      normal = get_hl_color("Normal", "fg"),
      const = get_hl_color("Constant", "fg"),
    }

    lualine.setup {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "mode",
            icon = "",
            color = { fg = highlights.statement },
          },
          {
            "branch",
            icon = "󰊢",
            color = { fg = highlights.error },
          },
          {
            "diff",
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󰝶 " },
            diagnostics_color = {},
          },
          { "harpoon2", color = { fg = highlights.special } },
          {
            macro_recording,
            cond = function()
              return macro_recording(true)
            end,
            color = { fg = highlights.string },
            icon = " ",
          },
          {
            "lsp_progress",
            colors = {
              percentage = highlights.string,
              title = highlights.ident,
              message = highlights.normal,
              spinner = highlights.func,
              lsp_client_name = highlights.ident,
              use = true,
            },
            spinner_symbols = { "◜", "◠", "◝", "◞", "◡", "◟" },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            padding = { left = 0, right = 1 },
            color = { fg = highlights.normal },
          },
          -- stylua: ignore
          {
            lsp_name,
            fmt = function(str) return "[" .. str .. "]" end,
            cond = function() return lsp_name(true) end,
            color = { fg = highlights.warn },
          },
          {
            "encoding",
            color = { fg = highlights.const },
          },
          {
            "fileformat",
            color = { fg = highlights.string },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = highlights.string },
          },
          {
            "progress",
            color = { fg = highlights.string },
          },
          {
            "location",
            color = { fg = highlights.func },
          },
        },
      },
      extensions = { "lazy", "mason", "trouble", "fugitive", "fzf", "man" },
    }
  end,
}
