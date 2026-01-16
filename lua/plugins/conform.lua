local function file_exists_glob(pattern)
  local root_dir = vim.fn.getcwd()
  local full_pattern = root_dir .. "/" .. pattern
  local files = vim.fn.glob(full_pattern, false, true)
  return #files > 0
end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require "conform"

    ---@type conform.FiletypeFormatterInternal|fun(bufnr: number):conform.FiletypeFormatterInternal
    local prettier_formatter = { "prettierd", "prettier", stop_after_first = true }

    ---@type conform.FiletypeFormatterInternal|fun(bufnr: number):conform.FiletypeFormatterInternal
    local javascript_formatter = prettier_formatter

    if file_exists_glob "*/biome.{json,jsonc}" then
      javascript_formatter = { "biome" }
    end

    conform.setup {
      formatters_by_ft = {
        javascript = javascript_formatter,
        typescript = javascript_formatter,
        javascriptreact = javascript_formatter,
        typescriptreact = javascript_formatter,
        json = javascript_formatter,
        jsonc = javascript_formatter,
        -- Prettier Formatter
        svelte = prettier_formatter,
        css = prettier_formatter,
        scss = prettier_formatter,
        html = prettier_formatter,
        vue = prettier_formatter,
        markdown = prettier_formatter,
        graphql = prettier_formatter,
        liquid = prettier_formatter,
        yaml = prettier_formatter,
        go = { "gofumpt" },
        lua = { "stylua" },
        python = { "isort", "ruff_format" },
        zsh = { "shfmt" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        nix = { "nixfmt" },
        c = { "clang_format" },
      },
      lsp_format = "last",
      formatters = {
        golines = {
          cwd = require("conform.util").root_file { ".editorconfig", "go.mod" },
          require_cwd = true,
          prepend_args = function(_, ctx)
            local textwidth = vim.api.nvim_get_option_value("textwidth", { buf = ctx.buf })
            if textwidth == 0 then
              return {}
            end
            return { "--max-len", tostring(textwidth) }
          end,
          args = { "--shorten-comments" },
        },
        shfmt = { extra_args = { "-i", "2", "-ci", "-bn" } },
        biome = {
          args = {
            "check",
            "--write",
            "--linter-enabled=false",
            "--formatter-enabled=true",
            "--organize-imports-enabled=true",
            "--stdin-file-path",
            "$FILENAME",
          },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }

    local function conform_format()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end

    vim.keymap.set({ "n", "v" }, "<leader>fm", conform_format, { desc = "Format file or range (in visual mode)" })
  end,
}
