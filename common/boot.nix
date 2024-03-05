{ config, lib, pkgs, ... }:

{
  boot = {
    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 5;
    };
    loader.timeout = 20;

    initrd.systemd.enable = true;

    tmp.cleanOnBoot = true;
  };
}
