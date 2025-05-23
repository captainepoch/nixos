{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    # VSCodium (Latest GitHub release)
    vscodium = pkgs.vscodium.overrideAttrs (oldAttrs: {
      version = "1.100.23258";
      src = pkgs.fetchurl {
        url =
          "https://github.com/VSCodium/vscodium/releases/download/1.100.23258/VSCodium-linux-x64-1.100.23258.tar.gz";
        hash = "sha256-6/ECgQbl7r4KI66BApOijIdJJP4nlDEgRE1JEMJcSDk=";
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
    kdePackages.kate
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
          tamasfe.even-better-toml
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
            version = "2025.3.11051009";
            sha256 = "sha256-k0pNrwYRmt1LAnVDaYh0SkTuy6ctuqLCFJ56QDH57AQ=";
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
            version = "17.9.0";
            sha256 = "sha256-au71N3gVDMKnTX9TXzGt9q4b3OM7s8gMHXBnIVZ/1CE=";
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
