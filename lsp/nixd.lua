return {
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
      },
      options = {
        home_manager = {
          expr = '(builtins.getFlake "/home/ephemeral/git/dotfiles").homeConfigurations.ephemeral.options',
        },
      },
    },
  },
}
