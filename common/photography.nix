{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    darktable = pkgs.darktable.overrideAttrs (oldAttrs: { version = "5.0.1"; });
  };

  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  environment.systemPackages = with pkgs; [ darktable ];
}
