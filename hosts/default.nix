{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;

  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  # nvidia = ../modules/nvidia;
  home-manager-module = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };

    users.b4mbus = ../modules/home;
  };

in {
  # My nick (b4mbus) is a leet for bambus (pl), which means bamboo (en).
  # Naturally, this means the host is called forest.

  forest = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        { networking.hostName = "forest"; }
        ./forest/hardware-configuration.nix
        core
        # nvidia
        bootloader
        home-manager-module

        { inherit home-manager; }
      ];

    specialArgs = { inherit inputs; };
  };
}
