final: prev:
let
  lib = final.lib;
  pkgDirs = lib.filterAttrs (_name: type: type == "directory")
    (builtins.readDir ./pkgs);
in lib.mapAttrs (name: _type:
  final.callPackage (./pkgs + "/${name}/package.nix") { }) pkgDirs
