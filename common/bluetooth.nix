{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware = {
    # Enables support for BT
    bluetooth.enable = true;
    # Powers up the default Bluetooth controller on boot
    bluetooth.powerOnBoot = true;
    # A2DP
    #bluetooth.settings = {
    #  General = {
    #    Enable = "Source,Sink,Media,Socket";
    #  };
    #};
    bluetooth.settings = {
      General = {
        ControllerMode = "dual";
      };

      Policy = {
        AutoEnable = "true";
      };
    };
  };

  # Audio by Bluetooth
  services.pulseaudio = {
    package = pkgs.pulseaudioFull;
    extraConfig = "load-module module-switch-on-connect";
  };

  services.blueman = {
    enable = true;
  };

  # Media keys on headsets
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}
