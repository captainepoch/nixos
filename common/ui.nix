{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ark
    libreoffice
    # Keyring
    gnome3.gnome-keyring
    libgnome-keyring
    # GTK Theme & Icons
    matcha-gtk-theme
    papirus-icon-theme
    # GPG stuff
    pinentry-gtk2
    # XFCE
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.xfce4-icon-theme
    xfce.xfce4-pulseaudio-plugin
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      fira-code
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Liberation Sans Regular" ];
        serif = [ "Liberation Serif Regular" ];
        monospace = [ "Liberation Mono Regular" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # GNOME Keyring
  services.gnome = {
    gnome-keyring.enable = true;
    tracker.enable = false;
    tracker-miners.enable = false;
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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  sound.mediaKeys = {
    enable = true;
    volumeStep = "5%";
  };

  programs = {
    dconf.enable = true;
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gtk2";
    };
  };
}
