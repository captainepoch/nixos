{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ android-udev-rules ];
  services.udev.packages = [ pkgs.android-udev-rules ];
  programs.adb.enable = true;

  users.extraUsers.epoch.extraGroups = [ "adbusers" ];
}
