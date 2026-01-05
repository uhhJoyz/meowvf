{
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool str;
  inherit (lib.nvim.types) mkPluginSetupOption;
  inherit (lib.nvim.binds) mkMappingOption;

  cfg = config.vim.utility.freeze;

in
{
  options.vim.utility.freeze = {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
        A tool for generating visually pleasing code screenshots.
      '';
    };

    mappings = {
      screenshot = mkMappingOption "Store screenshot to current working directory." "<leader>ss";
      screenshotToClipboard = mkMappingOption "Copy screenshotted code region to clipboard" "<leader>sc";
    };

    setupOpts = mkPluginSetupOption "freeze" { };
  };
}
