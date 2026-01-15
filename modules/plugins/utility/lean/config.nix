{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.vim.utility.lean;
in {
  config = mkIf cfg.enable {
    vim = {
      startPlugins = [
        "plenary-nvim"
      ];

      lazy.plugins.lean-nvim = {
        package = "lean-nvim";
        setupModule = "lean";
        inherit (cfg) setupOpts;
      };
    };
  };
}
