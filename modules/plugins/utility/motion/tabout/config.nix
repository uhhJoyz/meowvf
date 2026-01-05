{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.lua) toLuaObject;

  cfg = config.vim.utility.motion.tabout;
in
{
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins = {
        "tabout" = {
          package = "tabout";
          lazy = true;
          event = [ "BufEnter" ];
          after = ''require("tabout").setup(${toLuaObject cfg.setupOpts})'';
        };
      };
    };
  };
}
