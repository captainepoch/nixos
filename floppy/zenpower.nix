{ config, lib, pkgs, ... }:

{
  # Zenpower - Energy management for AMD Ryzen CPUs
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  boot.kernelModules = [ "zenpower" ];
}
