{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ android-tools ];

  users.extraUsers.epoch.extraGroups = [ "kvm" ];
}
