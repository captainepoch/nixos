{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    # VSCodium
    vscodium = pkgs.vscodium.overrideAttrs (oldAttrs: {
      version = "1.92.2.24228"; # Latest GitHub release
      src = pkgs.fetchurl {
        url =
          "https://github.com/VSCodium/vscodium/releases/download/1.92.2.24228/VSCodium-linux-x64-1.92.2.24228.tar.gz";
        hash = "sha256-5aOqIJYWqecdVrnKCtT9nD35BYvEzU9nqogFgyW2reE=";
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
          # ms-vscode.cpptools
          ms-vscode-remote.remote-containers
          stkb.rewrap
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "autopep8";
            publisher = "ms-python";
            version = "2024.1.11501016";
            sha256 = "sha256-1BYndKdICsHqxfe3ghJIpPrCTswYV3Ij+4U4fdICODE=";
          }
          {
            name = "flake8";
            publisher = "ms-python";
            version = "2023.13.12291011";
            sha256 = "sha256-xhAnRpgHiXb4DiY+tKRYvYMRWD8jHeq9lulqfLZ7Yq0=";
          }
          {
            name = "jinjahtml";
            publisher = "samuelcolvin";
            version = "0.20.0";
            sha256 = "sha256-wADL3AkLfT2N9io8h6XYgceKyltJCz5ZHZhB14ipqpM=";
          }
          {
            name = "language-gettext";
            publisher = "mrorz";
            version = "0.5.0";
            sha256 = "sha256-1hdT2Fai0o48ojNqsjW+McokD9Nzt2By3vzhGUtgaeA=";
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
            version = "0.1.29";
            sha256 = "sha256-ldvjDwWmOI2BXr4VjqsSMbA1nv5rc6a9bveO8fm8ee8=";
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
