{ config, lib, pkgs, ... }:

{
  # AMDGPU init module
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Setup GPU drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
}
