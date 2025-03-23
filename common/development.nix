{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    # VSCodium
    vscodium = pkgs.vscodium.overrideAttrs (oldAttrs: {
      version = "1.98.2.25078"; # Latest GitHub release
      src = pkgs.fetchurl {
        url =
          "https://github.com/VSCodium/vscodium/releases/download/1.98.2.25078/VSCodium-linux-x64-1.98.2.25078.tar.gz";
        hash = "sha256-qiSCrPScPtfoxVXpjapOUqzIAHlNsXwVAZNYN6CeuQo=";
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
          llvm-vs-code-extensions.vscode-clangd
          ms-python.flake8
          ms-python.isort
          ms-python.python
          ms-vscode-remote.remote-containers
          samuelcolvin.jinjahtml
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "autopep8";
            publisher = "ms-python";
            version = "2025.2.0";
            sha256 = "sha256-N1ryz3MieHinTcm5d1RVbGApMQAUhrDUpxDUdfEDmvU=";
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
            version = "1.8.33";
            sha256 = "sha256-7+Yo6X+t56tnZzepBKEo5hJdgLxiF3+83hSFqpkhVpA=";
          }
          {
            name = "vscode-astyle";
            publisher = "chiehyu";
            version = "0.9.0";
            sha256 = "sha256-eEuqMQ9+N91ByuLPAoLvcg7m9MEkENP3hsKVyskrSZQ=";
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
