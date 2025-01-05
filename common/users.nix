{ config, pkgs, lib, options, ... }:

{
  programs.zsh.enable = true;

  users.extraUsers.epoch = {
    description = "Adolph";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "networkmanager" "wheel" "plugdev" "dialout" ];
    shell = "${pkgs.zsh}/bin/zsh";
    packages = with pkgs; [
      brave
      calibre
      element-desktop
      exiftool
      gimp
      gopass
      htop
      isync
      libsecret
      msmtp
      mumble
      neomutt
      neovim
      nextcloud-client
      obsidian
      pavucontrol
      pinentry-gtk2
      senpai
      telegram-desktop
      transmission_4-qt
      unzip
      winbox4
      zip
    ];
  };
}
