{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
  enable = true;

  extras = {
    lang.nix.enable = true;
    lang.rust = {
      enable = true;
      installDependencies = true;        # Install ruff
      installRuntimeDependencies = true; # Install python3
    };
    lang.toml = {
      enable = true;
      installDependencies = true;        # Install gopls, gofumpt, etc.
      installRuntimeDependencies = true; # Install go compiler
    };
  };

  # Additional packages (optional)
  extraPackages = with pkgs; [
    nixd       # Nix LSP
    alejandra  # Nix formatter
  ];

  # Only needed for languages not covered by LazyVim extras
  treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    wgsl      # WebGPU Shading Language
    templ     # Go templ files
  ];
};
}
