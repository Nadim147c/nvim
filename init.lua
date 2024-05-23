vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"

-- load plugins
---@diagnostic disable-next-line: different-requires
require("lazy").setup({
    {
        {
            "catppuccin/nvim",
            name = "catppuccin",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme "catppuccin"
                require("catppuccin").setup {
                    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
                    flavor = "mocha",
                    transparent_background = vim.g.transparent_enabled or false,
                    term_colors = true,
                    integrations = {
                        cmp = true,
                        gitsigns = true,
                        nvimtree = true,
                        treesitter = true,
                        notify = true,
                        mini = {
                            enabled = true,
                            indentscope_color = "",
                        },
                    },
                }
            end,
        },

        {
            "xiyaowong/transparent.nvim",
            lazy = false,
            config = function()
                require("transparent").setup { extra_groups = { "NormalFloat", "NvimTreeNormal" } }
                require("transparent").clear_prefix "lualine"
                require("transparent").clear_prefix "nvim-tree"
            end,
        },
    },
    { import = "plugins" },
}, lazy_config)

require "options"
require "custom"

vim.schedule(function()
    require "mappings"
end)
