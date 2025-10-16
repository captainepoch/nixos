{ config, lib, pkgs, ... }:

{
  # AMDGPU init module
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Setup GPU drivers
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [ amdvlk ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };
}
