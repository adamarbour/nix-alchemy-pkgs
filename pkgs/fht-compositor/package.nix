{ pkgs, sources }:
let
  flake = (import sources.flake-compat { src = sources.fht-compositor; }).defaultNix;
  system = pkgs.stdenv.hostPlatform.system;
  pkgsFor =
    if flake ? packages && flake.packages ? ${system} then
      flake.packages.${system}
    else if flake ? defaultPackage && flake.defaultPackage ? ${system} then
      { default = flake.defaultPackage.${system}; }
    else
      throw "fht-compositor: flake does not expose packages.${system} or defaultPackage.${system}";

  drv = pkgsFor.default or pkgsFor.fht-compositor;
in drv
