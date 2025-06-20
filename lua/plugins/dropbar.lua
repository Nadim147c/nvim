local special_dirs = {
  HOME = vim.env.HOME,
  CONFIG = vim.env.XDG_CONFIG_HOME,
  GIT = vim.env.HOME .. "/git",
  NVIM = vim.env.HOME .. "/git/nvim",
  DOTFILES = vim.env.HOME .. "/git/dotfiles",
}

return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  config = function()
    local dropbar_api = require "dropbar.api"
    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    require("dropbar").setup {}
  end,
}
