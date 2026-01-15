{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum str;
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.types) mkPluginSetupOption luaInline;
in {
  options.vim.utility = {
    lean = {
      enable = mkEnableOption "supports the lean theorem prover within your neovim client";

      setupOpts = mkPluginSetupOption "lean" {
        mappings = mkEnableOption "use default keybinds.";
      };
    };
  };
}
