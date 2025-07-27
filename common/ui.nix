{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.ark
    libsForQt5.okular
    libreoffice
    xarchiver
    # Keyring
    gnome-keyring
    libgnome-keyring
    # GTK Theme & Icons
    matcha-gtk-theme
    papirus-icon-theme
    # GPG stuff
    pinentry-gnome3
    # XFCE
    xfce.xfce4-icon-theme
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ liberation_ttf noto-fonts noto-fonts-emoji ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Liberation Sans" ];
        serif = [ "Liberation Serif" ];
        monospace = [ "Liberation Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # GNOME Keyring
  services.gnome = {
    gnome-keyring.enable = true;
    tinysparql.enable = false;
    localsearch.enable = false;
  };

  # XFCE and xserver config
  services.xserver = {
    enable = true;

    xkb.layout = "es";

    deviceSection = ''
      Option "TearFree" "true"
    '';

    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true;
    dpi = 96;
  };

  ## Thumbnail support for images
  services.tumbler.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
    xfce4-pulseaudio-plugin
  ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # SSH and GPG config
  programs = {
    dconf.enable = true;
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
