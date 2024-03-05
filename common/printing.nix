{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    xsane
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
