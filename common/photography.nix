{ config, lib, pkgs, ... }:

{
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  environment.systemPackages = with pkgs; [ darktable ];
}
