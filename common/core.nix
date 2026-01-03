{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    dosfstools
    efibootmgr
    efitools
    efivar
    git
    gnupg
    gparted
    man-pages
    man-pages-posix
    os-prober
    wget
  ];

  # Allow unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  # Ensure that the TTY has the same layout as the X server
  console.useXkbConfig = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "es_ES.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ALL = "es_ES.UTF-8";
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };
    extraLocales = [ "C.UTF-8/UTF-8" "es_ES.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  # Enable regular garbage collection from the nix-store
  nix.gc = {
    automatic = true;
    options = "--delete-older-than +5";
  };

  hardware.enableRedistributableFirmware = true;
}

## Establish browser by default
# $ xdg-settings set default-web-browser librewolf.desktop
