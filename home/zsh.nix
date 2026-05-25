{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      ls = "eza";
      lz = "lazygit";
      yz = "yazi";
      nrt = "sudo nixos-rebuild test --flake ~/nixos/#prometheus";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos/#prometheus";
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 1000 ''
        export EZA_CONFIG_DIR="$HOME/.config/eza"
        export EZA_ICONS_AUTO=1
      '')
      #(lib.mkOrder 1500 ''
      #  eval "$(${pkgs.starship}/bin/starship init zsh)"
      #'')
    ];
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      package = pkgs.oh-my-zsh;
      #custom = "$HOME/.oh-my-custom";
      theme = "agnoster";
      plugins = [ "git" "z" "docker" "docker-compose" "eza" "fzf" ];
    };
  };
}
