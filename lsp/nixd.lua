local m = require "configs.lsp"

-- Get current user and hostname
local username = os.getenv "USER" or os.getenv "USERNAME"
local hostname = os.getenv "HOSTNAME" or io.popen("hostname"):read "*l"

-- Fallback values if not found
username = username or "ephemeral"
hostname = hostname or "chronoshift"

-- Create nixd settings with dynamic values
local nixd_settings = {
  capabilities = m.capabilities,
  cmd = { "nixd", "--inlay-hints=true", "--semantic-tokens=true" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      options = {
        nixos = {
          expr = string.format(
            [[
            let
              nixosOptions = (builtins.getFlake (builtins.toString ./.)).nixosConfigurations."%s".options;
              options = {
                nixos.always = nixosOptions;
                nixos.ifEanbled = nixosOptions;
              };
            in
              options
          ]],
            hostname
          ),
        },
        home = {
          expr = string.format(
            [[
            let
              homeOptions = (builtins.getFlake (builtits.toString ./.)).homeConfigurations."%s@%s".options;
              options = {
                home.always = homeOptions;
                home.ifEanbled = homeOptions;
              };
            in
              options
          ]],
            username,
            hostname
          ),
        },
      },
    },
  },
}

return nixd_settings
