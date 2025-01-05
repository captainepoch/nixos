{
  description = "Adolph's NixOS setup";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      floppy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;

        modules = [
          ./common/android.nix
          ./common/android-dev.nix
          ./common/amdcpu.nix
          ./common/bluetooth.nix
          ./common/boot.nix
          ./common/core.nix
          ./common/development.nix
          ./common/games.nix
          ./common/latex.nix
          ./common/network.nix
          ./common/nix-settings.nix
          ./common/photography.nix
          ./common/printing.nix
          ./common/streaming.nix
          ./common/ui.nix
          ./common/users.nix

          ./floppy/amdgpu.nix
          ./floppy/android-kvm.nix
          ./floppy/configuration.nix
          ./floppy/hardware-configuration.nix
          ./floppy/hdds.nix
          ./floppy/rival.nix
          ./floppy/zenpower.nix
          ./floppy/windows.nix
        ];
      };
    };
  };
}
