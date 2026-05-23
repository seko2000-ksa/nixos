{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "dionysus";

  services.seatd = {
    enable = true;
    user = "ksa";
    group = "video";
  };

  services.getty = {
    autologinUser = "ksa";
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    gamescope
  ];
}
