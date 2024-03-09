{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    # Android Studio
    android-studio = pkgs.android-studio.overrideAttrs (oldAttrs: {
      # "Android Studio Iguana (2023.2.1) [Feb. 29, 2024]"
      version = "2023.2.1.23";
      src = pkgs.fetchurl {
        url =
          "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.2.1.23/android-studio-2023.2.1.23-linux.tar.gz";
        sha256 = "0wx0slpya6d389aiy4lhgryxazx37la6hrgb1lsxq741ra08yrhv";
      };
    });

    # VSCodium
    vscodium = pkgs.vscodium.overrideAttrs (oldAttrs: {
      version = "1.87.1.24068"; # Latest GitHub release
      src = pkgs.fetchurl {
        url =
          "https://github.com/VSCodium/vscodium/releases/download/1.87.1.24068/VSCodium-linux-x64-1.87.1.24068.tar.gz";
        hash = "sha256-ucUX9xCbLNWX32U6dUh3nFIYPUDBvBBA0TkemQ26Mws=";
      };
    });
  };

  environment.systemPackages = with pkgs; [
    android-studio
    astyle
    gcc_latest
    gdb
    gnumake
    go
    lldb
    nixfmt

    (python3.withPackages (ps:
      with ps; [
        tkinter
        scapy
        nose
        pytest
        autoflake
        python-lsp-server
        pylint
        yapf
        importmagic
        virtualenv
      ]))

    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions;
        [
          arrterian.nix-env-selector
          bbenoist.nix
          brettm12345.nixfmt-vscode
          bungcip.better-toml
          esbenp.prettier-vscode
          golang.go
          ms-python.isort
          ms-python.python
          ms-vscode.cpptools
          ms-vscode-remote.remote-containers
          stkb.rewrap
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-astyle";
            publisher = "chiehyu";
            version = "0.9.0";
            sha256 = "sha256-eEuqMQ9+N91ByuLPAoLvcg7m9MEkENP3hsKVyskrSZQ=";
          }
          {
            name = "language-gettext";
            publisher = "mrorz";
            version = "0.4.0";
            sha256 = "sha256-haplFz1jWPTvRZ37nkSgqU3PQC3ewXYI0lp05z/cBOs=";
          }
          {
            name = "autopep8";
            publisher = "ms-python";
            version = "2023.9.13201008";
            sha256 = "sha256-1SQifs2ST3o6VqUOewHxOvxYheyHov6KDteict4n9Fc=";
          }
          {
            name = "flake8";
            publisher = "ms-python";
            version = "2023.13.10601010";
            sha256 = "sha256-BddTIwVc1itee4VbpVuqLX3Re07dr+69RsvYlTO966o=";
          }
          {
            name = "jinjahtml";
            publisher = "samuelcolvin";
            version = "0.20.0";
            sha256 = "sha256-wADL3AkLfT2N9io8h6XYgceKyltJCz5ZHZhB14ipqpM=";
          }
          {
            name = "sass-indented";
            publisher = "syler";
            version = "1.8.29";
            sha256 = "sha256-6RYI6Gu5UePTicmKm85ZnN5C19hQASc/t5lHWoKjpYk=";
          }
        ];
    })
  ];

  # Java
  programs.java = {
    enable = true;
    package = pkgs.openjdk17;
  };
}
