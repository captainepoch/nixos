{ config, lib, pkgs, ... }:

{
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
