final: prev:
let
  sources = ./npins;
  lib = final.lib;
  pkgDirs = lib.filterAttrs (_name: type: type == "directory")
    (builtins.readDir ./pkgs);
  myPkgs = lib.mapAttrs (name: _type: final.callPackage (./pkgs + "/${name}/package.nix") { inherit sources; }) pkgDirs;
in {
  mypkgs = myPkgs;
}
