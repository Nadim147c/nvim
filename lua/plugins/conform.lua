return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require "conform"

        conform.setup {
            formatters_by_ft = {
                javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
                typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
                svelte = { "biome", "prettierd", "prettier", stop_after_first = true },
                vue = { "biome", "prettierd", "prettier", stop_after_first = true },
                css = { "biome", "prettierd", "prettier", stop_after_first = true },
                html = { "biome", "prettierd", "prettier", stop_after_first = true },
                json = { "biome", "prettierd", "prettier", stop_after_first = true },
                jsonc = { "biome", "prettierd", "prettier", stop_after_first = true },
                markdown = { "biome", "prettierd", "prettier", stop_after_first = true },
                graphql = { "biome", "prettierd", "prettier", stop_after_first = true },
                liquid = { "biome", "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                go = { "gofumpt", "gofmt", stop_after_first = true },
                lua = { "stylua" },
                python = { "isort", "black" },
                zsh = { "shfmt" },
                bash = { "shfmt" },
                sh = { "shfmt" },
            },
            formatters = {
                shfmt = { extra_args = { "-i", "2", "-ci", "-bn" } },
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
