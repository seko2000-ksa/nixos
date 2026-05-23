{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.borgbackup.jobs.erebos-home = {
    paths = "/home/ksa";
    exclude = [
      "/home/ksa/.cache"
      "/home/ksa/.nix-defexpr"
      "/home/ksa/.nix-profile"
      "/home/ksa/.mozilla"
      "/home/ksa/.pki"
      "/home/ksa/.steam"
      "/home/ksa/.terraform.d"
      "/home/ksa/.var"
    ];
    encryption.mode = "repokey";
    encryption.passCommand = "cat /run/agenix/borg.erebos.age";
    environment.BORG_RSH = "ssh -i /home/ksa/.ssh/borg";
    repo = "ssh://borg@100.106.154.7:22/mnt/backups/erebos_new";
    compression = "auto,zstd";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
    startAt = [ ];
  };

  age.secrets."borg.erebos.age" = {
    file = ../../../secrets/borg.erebos.age;
    path = "/run/agenix/borg.erebos.age";
    owner = "ksa";
    group = "users";
    mode = "0400";
  };
}
