return {
  { "windwp/nvim-ts-autotag", event = "InsertEnter", config = true },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { "<leader><F5>", "<CMD> UndotreeToggle <CR>", desc = "Toggle undo tree" },
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
