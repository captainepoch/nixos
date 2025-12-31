{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/mnt/software" = {
    device = "/dev/disk/by-uuid/fc450243-e5f0-4b36-b92a-67cf017db1f6";
    fsType = "ext4";
    options = [ "defaults" "nofail" "x-gvfs-show" ];
  };
}
