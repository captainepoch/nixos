{ config, lib, pkgs, ... }:

let
  libratbag = pkgs.libratbag.overrideAttrs (oldAttrs: {
    version = "5578c6e3e1f5ad4375412d6fd54281e2e731fbda";
    src = pkgs.fetchFromGitHub {
      owner = "captainepoch";
      repo = "libratbag";
      rev = "5578c6e3e1f5ad4375412d6fd54281e2e731fbda";
      sha256 = "sha256-utwRohD+4aQG+BKo//ELCXPESw4Jfuvqk7VmpBlnqy4=";
    };
  });

  piper = pkgs.piper.overrideAttrs (oldAttrs: {
    version = "efa2712fcbc4ac1e9e9d1a7a85334c2a5dc9bab4";
    src = pkgs.fetchFromGitHub {
      owner = "libratbag";
      repo = "piper";
      rev = "efa2712fcbc4ac1e9e9d1a7a85334c2a5dc9bab4";
      sha256 = "0jsvfy0ihdcgnqljfgs41lys1nlz18qvsa0a8ndx3pyr41f8w8wf";
    };
  });
in {
  environment.systemPackages = with pkgs; [ libratbag piper usbutils ];

  services.dbus.packages = [ pkgs.libratbag ];
  services.ratbagd = { enable = true; };
}
