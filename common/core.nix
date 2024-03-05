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
    vim
    wget
  ];

  # Enable flakes (experimental)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
      LC_ALL = "en_GB.UTF-8";
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
    supportedLocales = [ "C.UTF-8/UTF-8"
                         "es_ES.UTF-8/UTF-8"
                         "en_US.UTF-8/UTF-8"
                         "en_GB.UTF-8/UTF-8" ];
  };

  # Optimize the nix store by default for new derivations
  nix.settings.auto-optimise-store = true;

  # Enable regular garbage collection from the nix-store
  nix.gc = {
    automatic = true;
    options = "--delete-older-than +5";
  };

  hardware.enableRedistributableFirmware = true;
}
