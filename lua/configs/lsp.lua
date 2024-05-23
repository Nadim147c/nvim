local on_attach = require "configs.lsp_defaults.on_attach"
local on_init = require "configs.lsp_defaults.on_init"
local capabilities = require "configs.lsp_defaults.capabilities"

local lspconfig = require "lspconfig"
require("neodev").setup {}

local function emmet_language_server()
    lspconfig.emmet_language_server.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        filetypes = { "css", "eruby", "html", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
    }
end

local function powershell_es()
    lspconfig.powershell_es.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        filetypes = { "ps1" },
        bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
        settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
    }
end

local function bashls()
    lspconfig.bashls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        filetypes = { "bash", "sh", "zsh" },
    }
end

local function lua_ls()
    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    }
end

local function tsserver()
    local function organize_imports()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
    end

    vim.keymap.set({ "n", "v" }, "<leader>fi", organize_imports, { desc = "Organize ts/js imports" })

    lspconfig.tsserver.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        init_options = { preferences = { disableSuggestions = false } },
        commands = {
            OrganizeImports = { organize_imports, description = "Organize Imports" },
        },
    }
end

require("mason-lspconfig").setup {
    ensure_installed = {},
    opts = {
        auto_install = true,
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup {
                on_attach = on_attach,
                on_init = on_init,
                capabilities = capabilities,
            }
        end,

        emmet_language_server = emmet_language_server,
        powershell_es = powershell_es,
        bashls = bashls,
        tsserver = tsserver,
        lua_ls = lua_ls,
    },
}
