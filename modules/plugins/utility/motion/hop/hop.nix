{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.nvim.binds) mkMappingOption;
in {
  options.vim.utility.motion.hop = {
    mappings = {
      hop = mkMappingOption "Jump to occurrences [hop.nvim]" "<leader>hh";
      hop2 = mkMappingOption "Jump to two-character sequences [hop.nvim]" "<leader>h2";
    };

    enable = mkEnableOption "Hop.nvim plugin (easy motion)";
  };
}
