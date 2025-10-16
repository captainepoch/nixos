{ config, pkgs, lib, options, ... }:

{
  # Nheko
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  programs.zsh.enable = true;

  users.extraUsers.epoch = {
    description = "Adolph";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "dialout" "networkmanager" "plugdev" "wheel" ];
    shell = "${pkgs.zsh}/bin/zsh";
    packages = with pkgs; [
      brave
      calibre
      exiftool
      gimp
      gopass
      htop
      isync
      librewolf
      libsecret
      msmtp
      mumble
      neomutt
      neovim
      nextcloud-client
      nheko
      obsidian
      pavucontrol
      pinentry-gtk2
      senpai
      telegram-desktop
      unzip
      winbox4
      zip
    ];
  };

  environment.sessionVariables = { "GDK_DISABLE" = "gles-api"; };
}
