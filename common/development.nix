{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config.packageOverrides = pkgs: {
    # VSCodium (Latest GitHub release)
    vscodium = pkgs.vscodium.overrideAttrs (old: {
      version = "1.143.17232";
      src = pkgs.fetchurl {
        url = "https://github.com/VSCodium/vscodium/releases/download/1.143.17232/VSCodium-linux-x64-1.143.17232.tar.gz";
        hash = "sha256-yhiVqgQL2RoJxwnXnqx4YtjBqgI3/cJbUD3uuLzYfv0=";
      };

      postPatch =
        builtins.replaceStrings
          [ "resources/app/node_modules/@vscode/ripgrep/bin/rg" ]
          [ "resources/app/node_modules/@vscode/ripgrep-universal/bin/linux-x64/rg" ]
          old.postPatch;

      postFixup = (old.postFixup or "") + ''
        rm -rf $out/lib/vscode/resources/app/extensions/microsoft-authentication
      '';
    });
  };

  environment.systemPackages = with pkgs; [
    astyle
    direnv
    gcc_latest
    gdb
    gnumake
    go
    hunspell
    hunspellDicts.es_ES
    lazygit
    libvirt
    lldb
    nixfmt
    nix-direnv
    ripgrep

    (python3.withPackages (
      ps: with ps; [
        autoflake
        importmagic
        pylint
        pytest
        python-lsp-server
        scapy
        tkinter
        virtualenv
        yapf
      ]
    ))

    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions =
        with vscode-extensions;
        [
          arrterian.nix-env-selector
          bbenoist.nix
          brettm12345.nixfmt-vscode
          tamasfe.even-better-toml
          esbenp.prettier-vscode
          golang.go
          llvm-vs-code-extensions.vscode-clangd
          mkhl.direnv
          ms-python.flake8
          ms-python.isort
          ms-python.python
          #ms-vscode-remote.remote-containers
          samuelcolvin.jinjahtml
          twxs.cmake
          xaver.clang-format
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "autopep8";
            publisher = "ms-python";
            version = "2026.5.13011008";
            sha256 = "sha256-cRwrlebS4Zihc9qSlOoZ+K0jdmvfPF42puKtnk5LswQ=";
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
            version = "18.4.1";
            sha256 = "sha256-xGp7T5sKS/CS6Kf1yUICyDIhWFXWYsQskenJiogvglQ=";
          }
          {
            name = "sass-indented";
            publisher = "syler";
            version = "1.8.33";
            sha256 = "sha256-7+Yo6X+t56tnZzepBKEo5hJdgLxiF3+83hSFqpkhVpA=";
          }
        ];
    })
  ];

  # Java
  programs.java = {
    enable = true;
    package = pkgs.openjdk21;
  };
}
