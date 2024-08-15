{ config, lib, pkgs, ... }:

let
  androidStudioPackages = pkgs.recurseIntoAttrs
    (pkgs.callPackage ../external/editors/android-studio { });
  android-studio = androidStudioPackages.stable;
in {
  nixpkgs.config.packageOverrides = pkgs: {
    # VSCodium
    vscodium = pkgs.vscodium.overrideAttrs (oldAttrs: {
      version = "1.92.1.24225"; # Latest GitHub release
      src = pkgs.fetchurl {
        url =
          "https://github.com/VSCodium/vscodium/releases/download/1.92.1.24225/VSCodium-linux-x64-1.92.1.24225.tar.gz";
        hash = "sha256-Q1zrZgRFkfVrQ0PwdKN62+JQutJjMs0K+v6cMNeCOfA=";
      };
    });

    android-tools =
      pkgs.android-tools.overrideAttrs (oldAttrs: { version = "34.0.5"; });
  };

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    astyle
    direnv
    emacs
    gcc_latest
    gdb
    gnumake
    go
    lazygit
    libvirt
    lldb
    nixfmt-classic
    scrcpy

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
            version = "0.5.0";
            sha256 = "sha256-1hdT2Fai0o48ojNqsjW+McokD9Nzt2By3vzhGUtgaeA=";
          }
          {
            name = "autopep8";
            publisher = "ms-python";
            version = "2024.1.11371013";
            sha256 = "sha256-LdcCbAEd+UedCYmhMxM9Ok0QalCT7HqC8iEdHySDADQ=";
          }
          {
            name = "flake8";
            publisher = "ms-python";
            version = "2023.13.11511011";
            sha256 = "sha256-nIP99QnM9PL1LVezN1jCNf7odqwXmgnr2yoq0/u8x58=";
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
            version = "1.8.30";
            sha256 = "sha256-g11s2hdu5/6+tDrxCNNzchJwj52665NPZovkZdOBZhA=";
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
