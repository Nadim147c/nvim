return {
  {
    "itchyny/vim-highlighturl",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("highlight url", { clear = true }),
        desc = "Disable URL highlights",
        pattern = { "fzf", "lazyterm" },
        command = "call highlighturl#disable_local()",
      })
    end,
  },
}
