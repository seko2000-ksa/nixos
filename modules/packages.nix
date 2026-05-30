{
  config,
  lib,
  pkgs,
  inputs,
  nur,
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
    typst
    poppler
    ledger
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
    openssl
    openssh
    glow
    unzip
    parallel
    superfile
    future-cursors
    obsidian
    statix
    imv
    maestral
    maestral-gui
    docker
    docker-compose
    #vpnc
  ];

  devPackages = with pkgs; [
    rustup
    cargo
    gcc
    rustlings
    terraform
    distrobox
    evolution 
    python314
    SDL2
    SDL2.dev
    SDL2_image
    SDL2_ttf
    SDL2_mixer
  ];

  appsPackages = with pkgs; [
    mpv
    telegram-desktop
    discord
    chromium
    #libreoffice
    #picard
    evince
    gnome-calculator
    evolution-ews
    katago
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
