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
      version = "1.135.06055";
      src = pkgs.fetchurl {
        url = "https://github.com/VSCodium/vscodium/releases/download/1.135.06055/VSCodium-linux-x64-1.135.06055.tar.gz";
        hash = "sha256-wJ2KyN1/UrCe4VnuJLRAVB39j5N6D2+IzEKMeOSO4fI=";
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
            version = "2026.5.12811008";
            sha256 = "sha256-0EQCXSw5K/QTzVb+WkTAmt7FifC/sAMp9I4UjIl/IQg=";
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
            version = "17.10.0";
            sha256 = "sha256-lfQsX27n7BCaM/z5rzRvGzTnbyg+C9YiAgHAnHdtHDo=";
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
    package = pkgs.openjdk17;
  };
}
