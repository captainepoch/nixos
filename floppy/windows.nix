# NOTE: Not using Windows, this config is deprecated. However, it is
# left into the Nix flakes just to keep the hardware clock synced.

{ config, lib, pkgs, ... }:

{
  # Set time compatible with Windows
  time.hardwareClockInLocalTime = true;
}
