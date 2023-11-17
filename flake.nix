{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
    let
      supportedSystems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ ]; });
    in
    {

      # nix build .\#pi5-image
      packages = forAllSystems (system: {
        pi5-image = self.nixosConfigurations.pi5.config.system.build.sdImage;
      });

      nixosConfigurations.pi5 = let system = "aarch64-linux"; pkgs = nixpkgsFor.${system}; in
        nixpkgs.lib.nixosSystem {
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            # nixos-hardware.nixosModules.raspberry-pi-4
            {
              # try out kernel versions here
              boot.kernelPackages = pkgs.linuxPackages_6_1;
              nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
              nix.registry.nixpkgs.flake = nixpkgs;
              sdImage.compressImage = true;
              sdImage.imageBaseName = "pi5-image";
              nixpkgs.overlays = [
                (final: super: {
                  makeModulesClosure = x:
                    super.makeModulesClosure (x // { allowMissing = true; });
                })
              ];
              # hardware.deviceTree.filter = pkgs.lib.mkDefault "bcm2712-*.dtb";
              nixpkgs.hostPlatform = pkgs.lib.mkDefault "${system}";
              system.stateVersion = "23.11";
            }
          ];
        };

    };

}
