{ lib, callPackage, sources, ... }:
let
  base = ./.;
  dirs = builtins.filter (name: builtins.pathExists (base + "/" + name + "/package.nix")) (builtins.attrNames (builtins.readDir base));
  pkgs = lib.genAttrs dirs (name: callPackage (base + "/" + name + "/package.nix") { inherit sources; });
in
  pkgs
