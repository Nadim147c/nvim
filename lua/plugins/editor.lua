return {
  { "windwp/nvim-ts-autotag", event = "InsertEnter", config = true },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { "<leader><F5>", "<CMD> UndotreeToggle <CR>", desc = "Toggle undo tree" },
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)", desc = "Accelerated down movement" },
      { "k", "<Plug>(accelerated_jk_gk)", desc = "Accelerated up movement" },
    },
  },
  {
    "numToStr/Comment.nvim",
    init = function()
      local function comment()
        require("Comment.api").toggle.linewise.current()
      end
      vim.keymap.set("n", "<leader>/", comment, { desc = "Comment toggle" })

      local visual_comment = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
      vim.keymap.set("v", "<leader>/", visual_comment, { desc = "Comment toggle" })
    end,
  },
}
