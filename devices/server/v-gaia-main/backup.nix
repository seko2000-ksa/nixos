{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.borgbackup.jobs.v-gaia-main-home = {
    paths = [
      "/home/ksa"
      "/var/lib/nixos-containers/forgejo"
      "/var/lib/nixos-containers/uptime"
      "/var/lib/kavita"
      "/var/backup/postgresql"
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
    ];
    encryption.mode = "repokey";
    encryption.passCommand = "cat /run/agenix/borg.v-gaia-main.age";
    environment.BORG_RSH = "ssh -i /home/ksa/.ssh/borg";
    repo = "ssh://borg@100.106.154.7:22/mnt/backups/v-gaia-main_home";
    compression = "auto,zstd";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
    preHook = ''
      cleanup() {
        systemctl start container@forgejo container@uptime
      }
      trap cleanup EXIT
      mkdir -p /var/backup/postgresql
      ${pkgs.sudo}/bin/sudo -u postgres ${pkgs.postgresql}/bin/pg_dumpall > /var/backup/postgresql/all_databases.sql
      systemctl stop container@forgejo container@uptime
    '';
    startAt = "daily";
  };
  age.secrets."borg.v-gaia-main.age" = {
    file = ../../../secrets/borg.v-gaia-main.age;
    path = "/run/agenix/borg.v-gaia-main.age";
    owner = "ksa";
    group = "users";
    mode = "0400";
  };
}
