final: prev:
let
  pkgDirs = final.lib.filterAttrs (_name: type: type == "directory")
    (builtins.readDir ./pkgs);
in final.lib.mapAttrs (name: _type:
  final.callPackage (./pkgs + "/${name}/package.nix") { }) pkgDirs
