{ config, lib, pkgs, ... }:

{
  boot = {
    # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

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
    loader.timeout = 5;

    initrd.systemd.enable = true;

    tmp.cleanOnBoot = true;
  };
}
