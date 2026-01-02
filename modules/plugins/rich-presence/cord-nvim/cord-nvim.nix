{ lib, ... }:
let
  inherit (lib.modules) mkRemovedOptionModule mkRenamedOptionModule;
  inherit (lib.options) mkEnableOption mkOption literalExpression;
  inherit (lib.types)
    bool
    int
    str
    enum
    nullOr
    attrsOf
    listOf
    ;
  inherit (lib.nvim.types) mkPluginSetupOption;
in
{
  options.vim.presence.cord-nvim = {
    enable = mkEnableOption "cord-nvim plugin for discord rich presence";

    setupOpts = mkPluginSetupOption "cord-nvim" {
      editor = mkOption {
        type = attrsOf (str);
        default = {
          client = "myow.nix";
          tooltip = "The one truly stable text editor.";
        };
        description = ''
          An attribute set of client and tooltip name to be displayed on your profile.
        '';
      };

      display = mkOption {
        type = attrsOf (str);
        default = {
          theme = "catppuccin";
          flavor = "dark";
        };
        description = "The theme of the image to be displayed.";
      };

      text = mkOption {
        type = attrsOf (str);
        default = {
          editing = "Editing a file...";
          viewing = "Viewing a file...";
          file_browser = "Browsing files...";
          workspace = "using Myow.nvim (the best modular config).";
        };
        description = "Log level to be used by the plugin";
      };
    };
  };
}
