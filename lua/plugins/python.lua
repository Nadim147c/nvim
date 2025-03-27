return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
  keys = {
    { "<leader>,v", "<cmd>VenvSelect<cr>" },
  },
  ---@type venv-selector.Config
  opts = {
    -- Your settings go here
  },
}
