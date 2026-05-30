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
    ../../../modules/baseline.nix # <-- shared config between laptop/desktop
    #../../../modules/flatpak.nix
    ../../../modules/niri.nix #     <-- niri environment
    ../../../modules/storagebox.nix
    ../../../modules/retroshare.nix
    #../../../modules/lazyvim.nix
    #../../../modules/nixvim.nix
    ../../../modules/packages.nix
    ../../../modules/yazi.nix
    ../../../modules/virtualization.nix
    ../../../modules/polkit.nix
  ];

  # hostname
  networking.hostName = "prometheus";
  hardware.cpu.amd.updateMicrocode = true;

  workstation = {
    baseline = {
      enable = true;              # enable baseline config
      packages = {
        tools = true;             # enable common suite of CLI tools
        dev = true;               # enable common langs/lang related tools
        apps = true;              # enable common desktop applications
      };
    }; 
    #nixvim.enable = true;         # enable nixvim configuration
    #lazyvim.enable = true;
    niri.enable = true;           # change to a different profile if you want
    #kde.enable= false;
    polkit.enable = true;
    yazi.enable = true;           # yazi
    virtualization.enable = true; # enable QEMU/KVM virtualization
    #flatpak = {
    #  enable = true;
    #  onCalendar = "weekly";
    #  packages = [
    #    "flathub:app/app.zen_browser.zen//stable"
    #    "flathub:app/com.github.tchx84.Flatseal//stable"
    #  ];
    #};
  };

  programs.nix-ld.enable = true;
 
 # Add any shared libraries your unpatched binaries require
  programs.nix-ld.libraries = with pkgs; [
    glibc
    stdenv.cc.cc
    openssl
   ];

  environment.systemPackages = with pkgs; [
    v4l-utils
    udiskie
    dnsmasq
    udev
    #pkgs.nur.repos.dcsunset.ogatak
    #pkgs.nur.repos.foolnotion.q5go
  ];
}
