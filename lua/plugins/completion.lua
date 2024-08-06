---@diagnostic disable: missing-fields
return {
    {
        "L3MON4D3/LuaSnip",
        build = function()
            local os_type = vim.fn.has "macunix" and "Mac" or vim.fn.has "unix" and "Unix-like" or "Windows"
            return os_type ~= "Windows" and "make install_jsregexp" or nil
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "f3fora/cmp-spell",
            "petertriho/cmp-git",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "SergioRibera/cmp-dotenv",
            "Snikimonkd/cmp-go-pkgs",
            "David-Kunz/cmp-npm",
            "davidsierradz/cmp-conventionalcommits",
        },
        config = function()
            require("cmp_git").setup()

            local cmp = require "cmp"
            local lspkind = require "lspkind"
            local luasnip = require "luasnip"

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "nvim_lsp_document_symbol" },
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = "path" } },
                    { { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }
                ),
            })

            cmp.setup.filetype({ "gitcommit" }, {
                sources = cmp.config.sources {
                    { name = "git" },
                    { name = "conventionalcommits" },
                    { name = "buffer" },
                },
            })

            cmp.setup.filetype("sh", {
                sources = cmp.config.sources {
                    { name = "dotenv" },
                    { name = "cmdline" },
                },
            })

            cmp.setup {
                snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
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
                    { name = "lazydev" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "go_pkgs" },
                    { name = "npm", keyword_length = 4 },
                    { name = "nvim_lsp_signature_help" },
                    { name = "conventionalcommits" },
                    { name = "git" },
                    { name = "path" },
                    -- { name = "spell" },
                }, {
                    { name = "buffer" },
                    { name = "plugins" },
                    { name = "calc" },
                    { name = "emoji" },
                }),
            }

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({ { name = "git" } }, { { name = "buffer" } }),
            })

            require("luasnip.loaders.from_vscode").lazy_load()
            local snippet_path = vim.fn.stdpath "config" .. "/lua/snippets"
            require("luasnip.loaders.from_lua").lazy_load { paths = { snippet_path } }

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
    },
}
