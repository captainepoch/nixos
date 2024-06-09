{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    darktable = pkgs.darktable.overrideAttrs (oldAttrs: { version = "4.6.1"; });
  };

  hardware.opengl.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  environment.systemPackages = with pkgs; [ darktable ];
}
