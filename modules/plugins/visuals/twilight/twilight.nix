{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) int float listOf string;
  inherit (lib.nvim.types) mkPluginSetupOption;
in {
  options.vim.visuals.twilight = {
    enable = mkEnableOption "makes zen mode extra-focused by graying out distant text [twilight.nvim]";

    setupOpts = mkPluginSetupOption "twilight" {
      context = mkOption {
        type = int;
        default = 2;
        description = "The number of lines away from the cursor that should be considered when choosing which areas to desaturate.";
      };
      expand = mkOption {
        type = listOf string;
        default = [
            "function"
            "method"
            "if_statement"
        ];
        description = "Defines which components should be considered a 'unit' when desaturating.";
      };
    };
  };
}
