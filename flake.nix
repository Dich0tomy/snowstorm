{
  description = "B4mbus'es cold dots.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lyrap-cursors.url = "github:b4mbus/lyrap-cursors-unofficial";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tokyo-night-tmux = {
      url = "github:janoamaral/tokyo-night-tmux";
      flake = false;
    };
  };

  outputs = { self, ... } @ inputs: let
    system = "x86_64-linux";

    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;

    packages.${system} = {
      lyrap-cursors = inputs.lyrap-cursors.packages.${system}.default;
    };

    nixosConfigurations = import ./hosts inputs;
  };
}
