{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.ark
    kdePackages.okular
    libreoffice
    xarchiver
    # GPG stuff
    pinentry-gnome3
    # GTK Theme & Icons
    matcha-gtk-theme
    papirus-icon-theme
    # Keyring
    gnome-keyring
    libgnome-keyring
    # XFCE
    xfce.xfce4-icon-theme
    xorg.xrdb
    xsettingsd
  ];

  environment.xfce.excludePackages = with pkgs.xfce; [ parole ];

  services.xserver.excludePackages = with pkgs; [ xterm ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ liberation_ttf noto-fonts noto-fonts-color-emoji ];

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

    xkb = {
      layout = "es";
      variant = "";
    };

    deviceSection = ''
      Option "TearFree" "true"
    '';

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

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

  # Enable sound with pipewire
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
