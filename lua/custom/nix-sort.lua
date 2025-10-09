local ts = vim.treesitter
local parsers = require "nvim-treesitter.parsers"

local M = {}

local function get_node_text(bufnr, node)
  local sr, sc, er, ec = node:range()
  local lines = vim.api.nvim_buf_get_text(bufnr, sr, sc, er, ec, {})
  return table.concat(lines, "\n")
end

function M.sort_nix_lists()
  local bufnr = vim.api.nvim_get_current_buf()
  local lang = parsers.get_buf_lang(bufnr)
  if lang ~= "nix" then
    return
  end

  local parser = parsers.get_parser(bufnr, lang)
  if not parser then
    return
  end
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Match list expressions that are the body of a variable_expression
  -- whose identifier is "pkgs"
  local query = ts.query.parse(
    lang,
    [[
(with_expression
  (variable_expression (identifier) @ident)
  (list_expression) @list) 
  ]]
  )

  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "ident" then
      local ident_text = vim.trim(get_node_text(bufnr, node))
      if ident_text ~= "pkgs" then
        -- skip non-pkgs
        goto continue
      end
    elseif name == "list" then
      local list_node = node
      local sr, _, er, _ = list_node:range()

      local line_before = vim.api.nvim_buf_get_lines(bufnr, sr, sr + 1, false)[1] or ""
      local prefix = line_before:match "^(.-)%[" or ""

      local children = {}
      for child in list_node:iter_children() do
        local t = child:type()
        if t ~= "[" and t ~= "]" then
          local text = vim.trim(get_node_text(bufnr, child))
          if text ~= "" then
            table.insert(children, { node = child, text = text })
          end
        end
      end

      if #children <= 1 then
        goto continue
      end

      table.sort(children, function(a, b)
        return a.text < b.text
      end)

      local sorted_lines = {}
      table.insert(sorted_lines, prefix .. "[")
      for _, c in ipairs(children) do
        table.insert(sorted_lines, "  " .. c.text)
      end
      table.insert(sorted_lines, "];")

      vim.api.nvim_buf_set_lines(bufnr, sr, er + 1, false, sorted_lines)
    end

    ::continue::
  end
end

-- Automatically sort before saving Nix files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    M.sort_nix_lists()
  end,
})

return M
