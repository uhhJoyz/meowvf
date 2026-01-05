{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;

  cfg = config.vim.utility.motion.portal;
in
{
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins = {
        "portal" = {
          package = "portal";
          lazy = true;
          event = [ "BufEnter" ];
          keys = [
            {
              mode = "n";
              key = "<c-o>";
              action = "<cmd>Portal jumplist backward<cr>";
            }
            {
              mode = "n";
              key = "<c-i>";
              action = "<cmd>Portal jumplist forward<cr>";
            }
          ];
          before = ''
            vim.g.clever_f_show_prompt = 1
            vim.g.clever_f_fix_key_direction = 1
            vim.g.clever_f_smart_case = 1
            vim.g.clever_f_chars_match_any_signs = ","
            vim.g.clever_f_mark_char_color = "@text.strong"
          '';
        };
      };
    };
  };
}
