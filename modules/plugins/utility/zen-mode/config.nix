{
  options,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.binds) mkKeymap;

  cfg = config.vim.utility.zen-mode;
  keys = cfg.mappings;

  inherit (options.vim.utility.zen-mode) mappings;
in
{
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins.zen-mode = {
        package = "zen-mode";
        inherit (cfg) setupOpts;
        event = [
          "BufAdd"
          "VimEnter"
        ];
      };
    };
  };
}
