{
  config,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryAnywhere;

  cfg = config.vim.visuals.twilight;
in
{
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins.twilight = {
        package = "twilight";
        inherit (cfg) setupOpts;
        event = [ "BufEnter" ];
      };
    };
  };
}
