return {
  { "b0o/schemastore.nvim", version = false },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "~/git/chroma.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
