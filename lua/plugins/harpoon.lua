return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"

    harpoon:setup()

    ---@param keys string
    ---@param func string|function
    ---@param desc string
    local function map(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = "Harpoon " .. desc })
    end


    -- stylua: ignore
    map("<leader>a", function() harpoon:list():add() end, "add to list")
    map("<leader>e", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, "show list")
    map("s", function()
      harpoon:list():next { ui_nav_wrap = true }
    end, "cycle trough harpoon list")
  end,
}
