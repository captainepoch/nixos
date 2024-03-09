{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    android-studio = pkgs.android-studio.overrideAttrs (oldAttrs: {
      version = "2023.2.1.23"; # "Android Studio Iguana (2023.2.1) [Feb. 29, 2024]"
      src = pkgs.fetchurl {
        url = "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.2.1.23/android-studio-2023.2.1.23-linux.tar.gz";
        sha256 = "0wx0slpya6d389aiy4lhgryxazx37la6hrgb1lsxq741ra08yrhv";
      };
    });
  };

  environment.systemPackages = with pkgs; [
    android-studio
    gcc_latest 
    gdb
    gnumake
    go
    lldb
    sublime
    #vscodium
    (python3.withPackages (ps: with ps; [tkinter scapy nose pytest autoflake python-lsp-server pylint yapf importmagic virtualenv]))

    # Manage VSCodium extensions
    /*(vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
      ];
    })*/
  ];

  # Java
  programs.java = {
    enable = true; 
    package = pkgs.openjdk17;
  };
}
