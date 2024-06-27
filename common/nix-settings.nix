{ config, lib, pkgs, nixpkgs, ... }:

{
  nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
  nix.settings = {
    substituters = [ "https://cache.nixos.org/" ];
    trusted-public-keys =
      [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };
  nix.registry.nixpkgs.flake = nixpkgs;
}
