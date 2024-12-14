{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obs-studio
    obs-studio-plugins.obs-gstreamer
    obs-studio-plugins.obs-vaapi
  ];
}
