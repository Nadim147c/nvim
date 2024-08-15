return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require "conform"
        conform.setup {
            formatters_by_ft = {
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                vue = { "prettierd", "prettier", stop_after_first = true },
                css = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                graphql = { "prettierd", "prettier", stop_after_first = true },
                liquid = { "prettierd", "prettier", stop_after_first = true },
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
