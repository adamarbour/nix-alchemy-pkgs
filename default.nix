{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  nixpkgs ? <nixpkgs>,
  pkgs ? import sources.nixpkgs {
    inherit system;
    config = { };
    overlays = [ ];
  },
}:
let
  lib = pkgs.lib;
  pkgDirs = lib.filterAttrs (_name: type: type == "directory")
    (builtins.readDir ./pkgs);
  packages = lib.mapAttrs (name: _type: pkgs.callPackage (./pkgs + "/${name}/package.nix") { inherit sources; }) pkgDirs;
in packages
