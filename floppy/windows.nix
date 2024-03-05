{ config, lib, pkgs, ... }:

{
  # Set time compatible with Windows
  time.hardwareClockInLocalTime = true;
}