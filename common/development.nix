{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    # VSCodium
    vscodium = pkgs.vscodium.overrideAttrs (oldAttrs: {
      version = "1.96.4.25026"; # Latest GitHub release
      src = pkgs.fetchurl {
        url =
          "https://github.com/VSCodium/vscodium/releases/download/1.96.4.25026/VSCodium-linux-x64-1.96.4.25026.tar.gz";
        hash = "sha256-yH3ZaBpGts9pzBZezqu9gJh/Fkn6aV1mpAMctNKisSQ=";
      };
    });
  };

  environment.systemPackages = with pkgs; [
    astyle
    direnv
    emacs
    emacs-all-the-icons-fonts
    gcc_latest
    gdb
    gnumake
    go
    lazygit
    libvirt
    lldb
    nix-direnv
    nixfmt-classic

    (python3.withPackages (ps:
      with ps; [
        tkinter
        scapy
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
          ms-python.flake8
          ms-python.isort
          ms-python.python
          ms-vscode-remote.remote-containers
          samuelcolvin.jinjahtml
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "autopep8";
            publisher = "ms-python";
            version = "2024.1.13171014";
            sha256 = "sha256-TMbSKa/7XmnHCHgjC2RQ6OppV7UvdZ4vCOSYixETVok=";
          }
          {
            name = "language-gettext";
            publisher = "mrorz";
            version = "0.5.0";
            sha256 = "sha256-1hdT2Fai0o48ojNqsjW+McokD9Nzt2By3vzhGUtgaeA=";
          }
          {
            name = "rewrap-revived";
            publisher = "dnut";
            version = "17.8.0";
            sha256 = "sha256-d0SjewsL1J0dui5/yCaZNI9Zw2xAh8lEJcD6eT347vk=";
          }
          {
            name = "sass-indented";
            publisher = "syler";
            version = "1.8.31";
            sha256 = "sha256-TmRPpDJsuJETOKIjTsHzy4LOPTOAg4q0DunLyv6FxhQ=";
          }
          {
            name = "vscode-astyle";
            publisher = "chiehyu";
            version = "0.9.0";
            sha256 = "sha256-eEuqMQ9+N91ByuLPAoLvcg7m9MEkENP3hsKVyskrSZQ=";
          }
          {
            name = "vscode-clangd";
            publisher = "llvm-vs-code-extensions";
            version = "0.1.33";
            sha256 = "sha256-NAQ7qT99vudcb/R55pKY3M5H6sV32aB4P8IWZKVQJas=";
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
