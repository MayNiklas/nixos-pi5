{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }: {

    # nix build .\#nixosConfigurations.pi5.config.system.build.sdImage
    nixosConfigurations.pi5 =
      let
        system = "aarch64-linux";
        pkgs = (import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        });
      in
      nixpkgs.lib.nixosSystem {
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          nixos-hardware.nixosModules.raspberry-pi-4
          {
            nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
            nix.registry.nixpkgs.flake = nixpkgs;
            sdImage.compressImage = false;
            sdImage.imageBaseName = "raspi-image";
            nixpkgs.overlays = [
              (final: super: {
                makeModulesClosure = x:
                  super.makeModulesClosure (x // { allowMissing = true; });
              })
            ];
            nixpkgs.hostPlatform = pkgs.lib.mkDefault "${system}";
            system.stateVersion = "23.11";
          }
        ];
      };

  };

}
