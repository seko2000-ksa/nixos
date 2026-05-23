{ config, lib, pkgs, ... }:
let
  cfg = config.workstation.retroshare;
in
{
  options.workstation.retroshare.enable =
    lib.mkEnableOption "Syncthing RetroArch share";

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "ksa";
      group = "users";
      dataDir = "/home/ksa/sync";
      configDir = "/home/ksa/.config/syncthing";
      overrideDevices = false;
      overrideFolders = false;
      openDefaultPorts = true;

      settings = {
        devices = {
          "manga" = {
            id = "I3J5UCJ-NZIOJCX-FIV6PUT-QSTITFA-4TI6PB7-MVR67TI-SW56QXD-6ARBAAE";
          };
        };
        folders = {
          "retro-bios" = {
            id = "p4epq-mmgmv";
            path = "/home/ksa/sync/retro/BIOS";
            devices = [ "manga" ];
            type = "receiveonly";
          };
          "retro-roms" = {
            id = "74edp-unucu";
            path = "/home/ksa/sync/retro/ROMs";
            devices = [ "manga" ];
            type = "receiveonly";
          };
          "retro-saves" = {
            id = "ymtp3-m4ngw";
            path = "/home/ksa/sync/retro/Saves";
            devices = [ "manga" ];
            type = "sendreceive";
          };
        };
      };
    };
  };
}
