{ config, lib, pkgs, ... }:

{
  # KVM AMD for Android emulators
  boot.kernelModules = [ "kvm-amd" ];
}
