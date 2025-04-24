vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("colorcolumn", { clear = true }),
  callback = function()
    if vim.bo.filetype == "gitcommit" then
      return
    end
    local tw = vim.opt.textwidth:get()
    if tw > 0 then
      vim.opt.colorcolumn = tostring(tw)
    else
      vim.opt.colorcolumn = ""
    end
  end,
})
