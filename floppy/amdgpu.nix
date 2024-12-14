{ config, lib, pkgs, ... }:

{
  # AMDGPU init module
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Setup GPU drivers
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [ amdvlk ];
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
}
