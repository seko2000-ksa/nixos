{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.borgbackup.jobs.void-home = {
    paths = [
      "/home/ksa"
      "/var/lib/nixos-containers/tuwunel"
    ];
    exclude = [
      "/home/ksa/.cache"
      "/home/ksa/.nix-defexpr"
      "/home/ksa/.nix-profile"
      "/home/ksa/.mozilla"
      "/home/ksa/.pki"
      "/home/ksa/.steam"
      "/home/ksa/.terraform.d"
      "/home/ksa/.var"
      "/home/ksa/matrix"
    ];
    encryption.mode = "repokey";
    encryption.passCommand = "cat /run/agenix/borg.void.age";
    environment.BORG_RSH = "ssh -i /home/ksa/.ssh/borg";
    repo = "ssh://borg@100.106.154.7:22/mnt/backups/void_home";
    compression = "auto,zstd";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
    preHook = ''
      systemctl stop container@tuwunel
    '';
    postHook = ''
      systemctl start container@tuwunel
      exit $exitStatus
    '';
    startAt = "daily";
  };

  age.secrets."borg.void.age" = {
    file = ../../../secrets/borg.void.age;
    path = "/run/agenix/borg.void.age";
    owner = "ksa";
    group = "users";
    mode = "0400";
  };
}
