{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;

  cfg = config.vim.utility.motion.clever-f-vim;
in
{
  config = mkIf cfg.enable {
    vim = {
      lazy.plugins = {
        "clever-f-vim" = {
          package = "clever-f-vim";
          lazy = true;
          event = [ "BufEnter" ];
          keys = [
            # FIXME: currently does nothing,
            # figure out how to make it assign in the proper order
            {
              mode = "n";
              key = "<esc>";
              action = "<cmd>noh<cr><Plug>(clever-f-reset)";
            }
            {
              mode = [
                "n"
                "v"
              ];
              key = ",";
              action = "<Plug>(clever-f-repeat-back)";
            }
            {
              mode = [
                "n"
                "v"
              ];
              key = ";";
              action = "<Plug>(clever-f-repeat-forward)";
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
