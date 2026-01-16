{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) attrNames;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) bool enum package;
  inherit (lib.meta) getExe' getExe;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.types) mkGrammarOption deprecatedSingleOrListOf;
  inherit (lib.nvim.attrsets) mapListToAttrs;
  inherit (lib.nvim.dag) entryAfter;

  cfg = config.vim.languages.lean;

  defaultServers = ["lean-nvim"];
  servers = {
    lean-nvim = {
      cmd = [(getExe' pkgs.lean4 "lean4")];
      filetypes = ["lean"];
      root_markers = [
        "README.md"
        ".git"
      ];
      capabilities = {
        textDocument = {
          completion = {
            editsNearCursor = true;
          };
        };
        offsetEncoding = ["utf-8" "utf-16"];
      };
      on_attach = mkLuaInline ''
        function(client, bufnr)
          local function switch_source_header(bufnr)
            local method_name = "textDocument/switchSourceHeader"
            local client = vim.lsp.get_clients({ bufnr = bufnr, name = "lean.nvim", })[1]
            if not client then
              return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
            end
            local params = vim.lsp.util.make_text_document_params(bufnr)
            client.request(method_name, params, function(err, result)
              if err then
                error(tostring(err))
              end
              if not result then
                vim.notify('corresponding file cannot be determined')
                return
              end
              vim.cmd.edit(vim.uri_to_fname(result))
            end, bufnr)
          end

          local function symbol_info()
            local bufnr = vim.api.nvim_get_current_buf()
            local lean_client = vim.lsp.get_clients({ bufnr = bufnr, name = "lean.nvim" })[1]
            if not lean_client or not lean_client.supports_method 'textDocument/symbolInfo' then
              return vim.notify('Lean client not found', vim.log.levels.ERROR)
            end
            local win = vim.api.nvim_get_current_win()
            local params = vim.lsp.util.make_position_params(win, lean_client.offset_encoding)
            lean_client:request('textDocument/symbolInfo', params, function(err, res)
              if err or #res == 0 then
                -- Clangd always returns an error, there is not reason to parse it
                return
              end
              local container = string.format('container: %s', res[1].containerName) ---@type string
              local name = string.format('name: %s', res[1].name) ---@type string
              vim.lsp.util.open_floating_preview({ name, container }, "", {
                height = 2,
                width = math.max(string.len(name), string.len(container)),
                focusable = false,
                focus = false,
                border = 'single',
                title = 'Symbol Info',
              })
            end, bufnr)
          end
        end
      '';
    };
  };
in {
  options.vim.languages.lean = {
    enable = mkEnableOption "Lean language support";

    treesitter = {
      enable = mkEnableOption "Lean treesitter" // {default = config.vim.languages.enableTreesitter;};
    };

    lsp = {
      enable = mkEnableOption "Lean LSP support" // {default = config.vim.lsp.enable;};

      servers = mkOption {
        description = "The Lean LSP server to use";
        type = deprecatedSingleOrListOf "vim.language.lean.lsp.servers" (enum (attrNames servers));
        default = defaultServers;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = [cfg.treesitter.cPackage cfg.treesitter.cppPackage];
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.servers =
        mapListToAttrs (name: {
          inherit name;
          value = servers.${name};
        })
        cfg.lsp.servers;
    })
  ]);
}
