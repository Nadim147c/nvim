local lsp_defults = require "configs.lsp.defaults"
local lspconfig = require "lspconfig"

return {
    lua_ls = function()
        local config = {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        }

        lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", lsp_defults, config))
    end,
}
