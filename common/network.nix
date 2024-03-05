{ config, lib, pkgs, ... }:

{
  networking = {
    usePredictableInterfaceNames = false;

    # Allow ICMP traffic
    firewall = {
      enable = false;
      allowPing = true;
    };

    # Disable IPv6
    enableIPv6 = false;
  };
}