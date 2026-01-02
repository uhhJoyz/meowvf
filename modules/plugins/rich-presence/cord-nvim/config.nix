{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.dag) entryAnywhere;
  inherit (lib.nvim.lua) toLuaObject;

  cfg = config.vim.presence.cord-nvim;
in {
  config = mkIf cfg.enable {
    vim.startPlugins = ["cord-nvim"];

    vim.pluginRC.cord-nvim = entryAnywhere ''
      -- Please see the cord.nvim docs for documentation on each setup option
      require("cord").setup(${toLuaObject cfg.setupOpts})
    '';
  };
}
