{ config, lib, pkgs, nixpkgs, ... }:

{
  nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
  nix.settings = {
    substituters = [ "https://cache.nixos.org/" "https://cache.iog.io" ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.iog.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };
  nix.registry.nixpkgs.flake = nixpkgs;
}
