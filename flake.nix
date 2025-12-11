{
  description = "Nixos Configuration for all my nixos machines";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
      nixpkgs,
      home-manager,
      stylix,
      ...
  } @ inputs: let
    user = "alexforsale";
    fullName = "Kristian Alexander P";
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosConfigurations = {
      uganda = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit user fullName inputs outputs;
          hostName = "uganda";
        };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/uganda

          home-manager.nixosModules.home-manager {
            home-manager = {
              #useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.${user}.imports = [];
              backupFileExtension = "hm-backup";
            };
          }
        ];
      };
    };
  };
}
