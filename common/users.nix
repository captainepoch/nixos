{ config, pkgs, options, ... }:

{
  programs.zsh.enable = true;

  users.extraUsers.epoch = {
    description = "Adolph";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "networkmanager" "wheel" ];
    shell = "${pkgs.zsh}/bin/zsh";
    packages = with pkgs; [ 
      calibre
      element-desktop
      firefox
      gimp
      gopass
      htop
      isync
      keepassxc
      librewolf
      libsecret
      msmtp
      mumble
      neomutt
      neovim
      nextcloud-client
      obs-studio
      pavucontrol
      pinentry-gtk2
      qbittorrent
      senpai
      telegram-desktop
    ];
  };
}
