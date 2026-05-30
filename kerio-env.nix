{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "kerio-env";
  nativeBuildInputs = with pkgs; [
    openssl
    dpkg
    stdenv
    debianutils
    libclang
    iptables
    iproute2
    zlib
  ];
  runScript = "bash";
}