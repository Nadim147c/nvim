---@diagnostic disable: missing-fields
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
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "saadparwaiz1/cmp_luasnip",
        "danymat/neogen",
        "onsails/lspkind.nvim",
    },
    config = function()
        require("cmp_git").setup()

        local cmp = require "cmp"
        local lspkind = require "lspkind"
        local luasnip = require "luasnip"
        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            formatting = {
                format = lspkind.cmp_format {
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    show_labelDetails = true,
                },
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
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "nvim_lsp" },
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

        require("luasnip.loaders.from_vscode").lazy_load()
        local snippet_path = vim.fn.stdpath "config" .. "/lua/snippets"
        require("luasnip.loaders.from_lua").lazy_load { paths = { snippet_path } }

        local neogen = require "neogen"
        neogen.setup { snippet_engine = "luasnip" }
        vim.keymap.set("n", "<leader>nt", "<CMD> Neogen type <CR>", { desc = "Neogen generate type" })
        vim.keymap.set("n", "<leader>nc", "<CMD> Neogen class <CR>", { desc = "Neogen generate class" })
        vim.keymap.set("n", "<leader>nf", "<CMD> Neogen func <CR>", { desc = "Neogen generate function" })
        vim.keymap.set("n", "<leader>nF", "<CMD> Neogen file <CR>", { desc = "Neogen generate file" })

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
