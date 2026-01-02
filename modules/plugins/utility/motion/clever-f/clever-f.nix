{ lib, ... }:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) nullOr str;
  inherit (lib.nvim.types) mkPluginSetupOption;
in
{
  options.vim.utility.motion.clever-f-vim = {
    enable = mkEnableOption "better navigation with f/F/t/T";
    setupOpts = mkPluginSetupOption "clever-f" { };
  };
}
