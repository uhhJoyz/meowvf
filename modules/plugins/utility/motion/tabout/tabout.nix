{ lib, ... }:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) nullOr str;
  inherit (lib.nvim.types) mkPluginSetupOption;
in
{
  options.vim.utility.motion.tabout = {
    enable = mkEnableOption "tab out of parenthesis, quotes, etc. while in insert mode";
    setupOpts = mkPluginSetupOption "tabout" { };
  };
}
