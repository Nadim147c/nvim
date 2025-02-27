local function visual_stage()
  local first_line = vim.fn.line "v"
  local last_line = vim.fn.getpos(".")[2]
  require("gitsigns").stage_hunk { first_line, last_line }
  -- Switchback to normal mode, there maybe a cleaner way to do this
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "t", false)
end

return {
  { "tpope/vim-fugitive", event = "VeryLazy" },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function opts(desc) return { buffer = bufnr, desc = "Gitsings " .. desc } end

        local map = vim.keymap.set

        map("n", "<leader>gr", gs.reset_hunk, opts "Reset Hunk")
        map("n", "<leader>gp", gs.preview_hunk, opts "Preview Hunk")
        map("n", "<leader>gb", gs.blame_line, opts "Blame Line")
        map("n", "<leader>gs", gs.stage_hunk, opts "Stage Hunk")
        map("x", "<leader>gs", visual_stage, opts "Stage Hunk (Selected)")
      end,
    },
  },
}
