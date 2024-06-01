return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require "conform"
        conform.setup {
            formatters_by_ft = {
                javascript = { { "prettierd", "prettier" } },
                typescript = { { "prettierd", "prettier" } },
                javascriptreact = { { "prettierd", "prettier" } },
                typescriptreact = { { "prettierd", "prettier" } },
                svelte = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                html = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                markdown = { { "prettierd", "prettier" } },
                graphql = { { "prettierd", "prettier" } },
                liquid = { { "prettierd", "prettier" } },
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

        local function format_on_save()
            conform.format {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            }
        end

        vim.keymap.set({ "n", "v" }, "<leader>fm", format_on_save, { desc = "Format file or range (in visual mode)" })
    end,
}
