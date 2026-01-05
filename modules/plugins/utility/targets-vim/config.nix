{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.vim.utility.targets;
  mkLznKey = mode: key: {
    inherit mode key;
  };
in {
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins.targets-vim = {
        package = "targets-vim";
        inherit (cfg) setupOpts;

        event = ["BufReadPre" "BufNewFile"];
      };
    };
  };
}
