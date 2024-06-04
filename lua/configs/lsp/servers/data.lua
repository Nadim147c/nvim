local lsp_defults = require "configs.lsp.defaults"
local lspconfig = require "lspconfig"

return {
    yamlls = function()
        local config = {
            settings = {
                yaml = {
                    format = { enable = true },
                    schemaStore = { enable = true },
                },
            },
        }
        lspconfig.yamlls.setup(vim.tbl_deep_extend("force", lsp_defults, config))
    end,
}
