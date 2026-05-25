{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.workstation.baseline.packages;
  future-cursors = pkgs.callPackage ../pkgs/future-cursor.nix { };
  toolsPackages = with pkgs; [
    wget
    git
    btop
    fzf
    far2l
    zoxide
    jq
    grim
    slurp
    satty
    poppler
    fd
    curl
    tree
    eza
    alacritty
    fastfetch
    #starship
    lazygit
    nixfmt
    blueman
    ffmpeg
    whois
    parted
    usbutils
    smartmontools
    pciutils
    file
    dig
    #oh-my-zsh
    autojump
    screen
    unzip
    parallel
    future-cursors
    obsidian
    statix
    maestral
    maestral-gui
  ];

  devPackages = with pkgs; [
    rustup
    cargo
    gcc
    rustlings
    terraform
    distrobox
  ];

  appsPackages = with pkgs; [
    vlc
    telegram-desktop
    discord
    chromium
    #libreoffice
    picard
    gnome-calculator
  ];
in
{
  options.workstation.baseline.packages = {
    tools = lib.mkEnableOption "CLI tools and utilities";
    dev = lib.mkEnableOption "Development tools";
    apps = lib.mkEnableOption "Desktop applications";
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.tools toolsPackages)
      ++ (lib.optionals cfg.dev devPackages)
      ++ (lib.optionals cfg.apps appsPackages);
  };
}
