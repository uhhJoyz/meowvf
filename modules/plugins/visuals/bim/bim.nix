{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) int float listOf string;
  inherit (lib.nvim.types) mkPluginSetupOption;
in {
  options.vim.visuals.bim = {
    enable = mkEnableOption "makes multi-key insert-mode keybinds better by removing their display lag";
    setupOpts = mkPluginSetupOption "bim" {};
  };
}
