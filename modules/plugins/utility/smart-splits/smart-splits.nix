{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;
  inherit (lib.nvim.types) mkPluginSetupOption;
  inherit (lib.nvim.binds) mkMappingOption;
in
{
  options.vim.utility.smart-splits = {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
        Whether to enable smart-splits.nvim, a Neovim plugin for smart,
        seamless, directional navigation and resizing of splits.

        Supports tmux, Wezterm, Kitty, and Zellij multiplexer integrations.
      '';
    };

    setupOpts = mkPluginSetupOption "smart-splits" { };

    keymaps = {
      resize_left = mkMappingOption "Resize Window/Pane Left" "<leader>w<c-h>";
      resize_down = mkMappingOption "Resize Window/Pane Down" "<leader>w<c-j>";
      resize_up = mkMappingOption "Resize Window/Pane Up" "<leader>w<c-k>";
      resize_right = mkMappingOption "Resize Window/Pane Right" "<leader>w<c-l>";
      move_cursor_left = mkMappingOption "Focus Window/Pane on the Left" "<leader>wh";
      move_cursor_down = mkMappingOption "Focus Window/Pane Below" "<leader>wj";
      move_cursor_up = mkMappingOption "Focus Window/Pane Above" "<leader>wk";
      move_cursor_right = mkMappingOption "Focus Window/Pane on the Right" "<leader>wl";
      move_cursor_previous = mkMappingOption "Focus Previous Window/Pane" "<leader>wp";
      swap_buf_left = mkMappingOption "Swap Buffer Left" "<leader>w<s-h>";
      swap_buf_down = mkMappingOption "Swap Buffer Down" "<leader>w<s-j>";
      swap_buf_up = mkMappingOption "Swap Buffer Up" "<leader>w<s-k>";
      swap_buf_right = mkMappingOption "Swap Buffer Right" "<leader>w<s-l>";
    };
  };
}
