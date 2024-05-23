return {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "f3fora/cmp-spell",
        "petertriho/cmp-git",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("cmp_git").setup()

        local cmp = require "cmp"

        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lua" },
                { name = "path" },
                { name = "calc" },
                { name = "plugins" },
                -- { name = "spell" },
            }, {
                { name = "buffer" },
            }),
        }

        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({ { name = "git" } }, { { name = "buffer" } }),
        })

        local snippet_path = vim.fn.stdpath "config" .. "/snippets"
        require("luasnip.loaders.from_vscode").lazy_load { paths = snippet_path }

        vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
                if
                    require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                    and not require("luasnip").session.jump_active
                then
                    require("luasnip").unlink_current()
                end
            end,
        })
    end,
}
