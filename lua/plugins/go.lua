return {
  "olexsmir/gopher.nvim",
  ft = "go",
  build = function()
    -- Install depdencies
    vim.cmd.GoInstallDeps()
  end,
  opts = {},
}
