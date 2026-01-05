{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.nvim.lua) toLuaObject;

  cfg = config.vim.utility.freeze;
  inherit (options.vim.utility.freeze) mappings;
in
{
  config = mkIf cfg.enable {
    vim = {
      extraPackages = [
        pkgs.charm-freeze
      ];

      lazy.plugins.freeze = {
        package = "freeze";
        inherit (cfg) setupOpts;

        event = [
          "VimEnter"
        ];
        after = ''require("freeze-code").setup(${toLuaObject cfg.setupOpts})'';

        keys = [
          (mkKeymap [ "n" "v" ] cfg.mappings.screenshot ":Freeze<cr>" {
            desc = mappings.screenshot.description;
          })
          (mkKeymap [ "n" "v" ] cfg.mappings.screenshotToClipboard ":Freeze<cr>:lua vim.notify('this feature is currently not implemented, defaulted to screenshot behavior')" {
            desc = mappings.screenshotToClipboard.description;
          })
        ];

      };
    };
  };
}
