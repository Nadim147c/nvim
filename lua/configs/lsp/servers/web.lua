local lsp_defaults = require "configs.lsp.defaults"
local lspconfig = require "lspconfig"

return {
    emmet_language_server = function()
        local config = {
            filetypes = { "css", "eruby", "html", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
        }
        lspconfig.emmet_language_server.setup(vim.tbl_deep_extend("force", lsp_defaults, config))
    end,

    tsserver = function()
        local function organize_imports()
            local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
            }
            vim.lsp.buf.execute_command(params)
        end

        local config = {
            on_attach = function(_, bufnr)
                vim.keymap.set({ "n", "v" }, "<leader>fi", organize_imports, { desc = "Organize ts/js imports" })
                lsp_defaults.on_attach(_, bufnr)
            end,
            init_options = { preferences = { disableSuggestions = false } },
            commands = {
                OrganizeImports = { organize_imports, description = "Organize Imports" },
            },
        }
        lspconfig.tsserver.setup(vim.tbl_deep_extend("force", lsp_defaults, config))
    end,
}
