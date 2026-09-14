{
  config,
  pkgs,
  lib,
  options,
  ...
}:

{
  # Nheko
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  programs.zsh.enable = true;

  users.extraUsers.epoch = {
    description = "Adolph";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "audio"
      "dialout"
      "networkmanager"
      "plugdev"
      "wheel"
    ];
    shell = "${pkgs.zsh}/bin/zsh";
    packages = with pkgs; [
      brave
      btop
      exiftool
      gopass
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
      senpai
      telegram-desktop
      unzip
      vlc
      winbox4
      zip
    ];
  };

  environment.sessionVariables = {
    "GDK_DISABLE" = "gles-api";
  };
}
