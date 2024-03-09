{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ xsane ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
