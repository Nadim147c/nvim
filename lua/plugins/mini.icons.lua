return {
  {
    "echasnovski/mini.icons",
    version = "*",
    lazy = false,
    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
