{ config, lib, pkgs, nixpkgs, ... }:

{
  nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.settings = {
    # Optimize the nix store by default for new derivations
    auto-optimise-store = true;
    # Enable flakes (experimental)
    experimental-features = [ "nix-command" "flakes" ];
    # Cache for updates
    substituters = [
      "https://cache.nixos.org?priority=1"
      "https://nix-community.cachix.org?priority=2"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
