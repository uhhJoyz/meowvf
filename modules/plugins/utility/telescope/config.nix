{
  options,
  config,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.strings) optionalString concatMapStringsSep;
  inherit (lib.lists) optionals concatLists;
  inherit (lib.nvim.binds) pushDownDefault mkKeymap;

  cfg = config.vim.telescope;

  keys = cfg.mappings;
  inherit (options.vim.telescope) mappings;
  inherit (cfg) theme;
  applyTheme = s: ("<cmd>" + s + (if theme != "" then " theme=" + theme + "<cr>" else "<cr>"));
in
{
  config = mkIf cfg.enable {
    vim = {
      startPlugins = [ "plenary-nvim" ] ++ concatLists (map (x: x.packages) cfg.extensions);

      lazy.plugins.telescope = {
        package = "telescope";
        setupModule = "telescope";
        inherit (cfg) setupOpts;

        # HACK: workaround until https://github.com/NotAShelf/nvf/issues/535 gets resolved
        before = ''
          vim.g.loaded_telescope = nil
        '';

        after =
          let
            enabledExtensions = map (x: x.name) cfg.extensions;
          in
          ''
            local telescope = require("telescope")
            ${optionalString config.vim.ui.noice.enable "telescope.load_extension('noice')"}
            ${optionalString config.vim.notify.nvim-notify.enable "telescope.load_extension('notify')"}
            ${optionalString config.vim.projects.project-nvim.enable "telescope.load_extension('projects')"}
            ${concatMapStringsSep "\n" (x: "telescope.load_extension('${x}')") enabledExtensions}
          '';

        cmd = [ "Telescope" ];

        keys = [
          (mkKeymap "n" keys.findFiles (applyTheme "Telescope find_files") {
            desc = mappings.findFiles.description;
          })
          (mkKeymap "n" keys.findKeys (applyTheme "Telescope keymaps") { desc = mappings.findKeys.description; })
          (mkKeymap "n" keys.liveGrep (applyTheme "Telescope live_grep") {
            desc = mappings.liveGrep.description;
          })
          (mkKeymap "n" keys.buffers (applyTheme "Telescope buffers") { desc = mappings.buffers.description; })
          (mkKeymap "n" keys.helpTags (applyTheme "Telescope help_tags") {
            desc = mappings.helpTags.description;
          })
          (mkKeymap "n" keys.open "<cmd>Telescope<cr>" { desc = mappings.open.description; })
          (mkKeymap "n" keys.resume (applyTheme "Telescope resume") { desc = mappings.resume.description; })

          (mkKeymap "n" keys.gitFiles (applyTheme "Telescope git_files") {
            desc = mappings.gitFiles.description;
          })
          (mkKeymap "n" keys.gitCommits (applyTheme "Telescope git_commits") {
            desc = mappings.gitCommits.description;
          })
          (mkKeymap "n" keys.gitBufferCommits (applyTheme "Telescope git_bcommits") {
            desc = mappings.gitBufferCommits.description;
          })
          (mkKeymap "n" keys.gitBranches (applyTheme "Telescope git_branches") {
            desc = mappings.gitBranches.description;
          })
          (mkKeymap "n" keys.gitStatus (applyTheme "Telescope git_status") {
            desc = mappings.gitStatus.description;
          })
          (mkKeymap "n" keys.gitStash (applyTheme "Telescope git_stash") {
            desc = mappings.gitStash.description;
          })
        ]
        ++ (optionals config.vim.lsp.enable [
          (mkKeymap "n" keys.lspDocumentSymbols (applyTheme "Telescope lsp_document_symbols") {
            desc = mappings.lspDocumentSymbols.description;
          })
          (mkKeymap "n" keys.lspWorkspaceSymbols (applyTheme "Telescope lsp_workspace_symbols") {
            desc = mappings.lspWorkspaceSymbols.description;
          })

          (mkKeymap "n" keys.lspReferences (applyTheme "Telescope lsp_references") {
            desc = mappings.lspReferences.description;
          })
          (mkKeymap "n" keys.lspImplementations (applyTheme "Telescope lsp_implementations") {
            desc = mappings.lspImplementations.description;
          })
          (mkKeymap "n" keys.lspDefinitions (applyTheme "Telescope lsp_definitions") {
            desc = mappings.lspDefinitions.description;
          })
          (mkKeymap "n" keys.lspTypeDefinitions (applyTheme "Telescope lsp_type_definitions") {
            desc = mappings.lspTypeDefinitions.description;
          })
          (mkKeymap "n" keys.diagnostics (applyTheme "Telescope diagnostics") {
            desc = mappings.diagnostics.description;
          })
        ])
        ++ optionals config.vim.treesitter.enable [
          (mkKeymap "n" keys.treesitter (applyTheme "Telescope treesitter") {
            desc = mappings.treesitter.description;
          })
        ]
        ++ optionals config.vim.projects.project-nvim.enable [
          (mkKeymap "n" keys.findProjects (applyTheme "Telescope projects") {
            desc = mappings.findProjects.description;
          })
        ];
      };

      binds.whichKey.register = pushDownDefault {
        "<leader>f" = "+Telescope";
        "<leader>fl" = "Telescope LSP";
        "<leader>fm" = "Cellular Automaton";
        "<leader>fv" = "Telescope Git";
        "<leader>fvc" = "Commits";
      };
    };
  };
}
