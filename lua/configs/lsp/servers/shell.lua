local lsp_defults = require "configs.lsp.defaults"
local lspconfig = require "lspconfig"

return {
    bashls = function()
        local config = {
            filetypes = { "bash", "sh", "zsh" },
        }
        lspconfig.bashls.setup(vim.tbl_deep_extend("force", lsp_defults, config))
    end,

    powershell_es = function()
        local config = {
            filetypes = { "ps1" },
            bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
            settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
        }
        lspconfig.powershell_es.setup(vim.tbl_deep_extend("force", lsp_defults, config))
    end,
}
