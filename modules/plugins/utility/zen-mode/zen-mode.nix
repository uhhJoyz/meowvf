{ lib, ... }:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) anything attrsOf bool;
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.types) mkPluginSetupOption;
  inherit (lib.nvim.binds) mkMappingOption;
in
{
  options.vim.utility.zen-mode = {
    enable = mkEnableOption ''
      A lower-stimulation editing mode [zen-mode]
    '';

    mappings = {
      toggleZen = mkMappingOption "Toggle Zen mode on/off" "<leader>uz";
    };

    setupOpts = mkPluginSetupOption "zen-mode" {
      window = mkOption {
        type = (attrsOf anything);
        default = {
          backdrop = 1;
          width = mkLuaInline ''
            vim.fn.winwidth(0) - 16
          '';
          height = mkLuaInline ''
            vim.fn.winheight(0) + 1
          '';
        };
      };
    };
  };
}
