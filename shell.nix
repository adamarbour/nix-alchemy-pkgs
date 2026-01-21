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
  packages = import ./default.nix { inherit system nixpkgs pkgs; };
in pkgs.mkShell {
  packages = with pkgs; [
    alejandra
    cachix
    git
    npins
  ];

  # Convenience: makes `repoPkgs.<name>` visible via `nix repl`, etc.
  REPO_PACKAGES = builtins.toJSON (builtins.attrNames packages);
}
