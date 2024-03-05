{ config, pkgs, options, ... }:

{
  # Networking config
  networking = {
    hostName = "floppy";

    # Delegate networking to HostManager
    networkmanager = {
      enable = true;
      ethernet.macAddress = "preserve";
    };
  };

  # List packages installed in system profile. To search, run:
  environment.variables.EDITOR = "nano";

  # Supposedly better for the SSD.
  #fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  system.stateVersion = "23.11";
}
