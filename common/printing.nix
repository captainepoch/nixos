{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ xsane ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = with pkgs; [ brlaser cups-filters cups-browsed gutenprint ];
  };

  hardware.printers = {
    ensurePrinters = [{
      name = "Brother_DCP-L2627DWE";
      location = "Home";
      deviceUri = "ipp://10.0.7.41/ipp/print";
      model = "everywhere";
    }];
    ensureDefaultPrinter = "Brother_DCP-L2627DWE";
  };
}
