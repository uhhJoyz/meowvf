{
  config,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryAnywhere;

  cfg = config.vim.visuals.bim;
in
{
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins.bim = {
        package = "bim";
        inherit (cfg) setupOpts;
        event = [ "BufEnter" ];
      };
    };
  };
}
