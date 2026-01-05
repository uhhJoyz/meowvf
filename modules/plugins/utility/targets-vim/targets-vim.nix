{
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool str;
  inherit (lib.nvim.types) mkPluginSetupOption;

  cfg = config.vim.utility.targets;
in
{
  options.vim.utility.targets = {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
        Whether to enable targets-vim, a Vim plugin which adds additional targets to the 'o' mode.
      '';
    };
    setupOpts = mkPluginSetupOption "targets-vim" { };
  };
}
