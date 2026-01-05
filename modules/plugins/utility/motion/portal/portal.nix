{ lib, ... }:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) nullOr str;
  inherit (lib.nvim.types) mkPluginSetupOption;
in
{
  options.vim.utility.motion.portal = {
    enable = mkEnableOption "visually transparent indicators for the jumplist";
    setupOpts = mkPluginSetupOption "portal" { };
  };
}
