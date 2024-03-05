{
  description = "Adolph's NixOS setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      floppy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;

        modules = [
          ./common/android.nix
          ./common/boot.nix
          ./common/core.nix
          ./common/development.nix
          ./common/network.nix
          ./common/ui.nix
          ./common/users.nix

          ./floppy/configuration.nix
          ./floppy/hardware-configuration.nix
          ./floppy/amdgpu.nix
          ./floppy/zenpower.nix
          ./floppy/windows.nix
        ];
      };
    };
  };
}
