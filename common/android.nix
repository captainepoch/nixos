{ config, lib, pkgs, ... }:

{
  programs.adb.enable = true;

  users.extraUsers.epoch.extraGroups = [ "adbusers" "kvm" ];
}
