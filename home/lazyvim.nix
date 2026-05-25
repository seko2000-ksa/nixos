{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;

    extras = {
      lang.nix.enable = true;
      lang.rust = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
        config = ''
        return {
          "neovim/nvim-lspconfig",
          opts = {
            servers = {
              rust_analyzer = {
                settings = {
                  ["rust-analyzer"] = {
                    cargo = { features = "all" },
                  },
                },
              },
            },
          },
        }
        '';
      };

      lang.toml = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };

      lang.typst = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };

      lang.docker = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };

    };

    # Additional packages (optional)
    extraPackages = with pkgs; [
      nixd # Nix LSP
      alejandra # Nix formatter
    ];

    # Only needed for languages not covered by LazyVim extras
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      wgsl # WebGPU Shading Language
      templ # Go templ files
    ];
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
