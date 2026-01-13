{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      sharedModules = [
        ./home.nix
      ];
    in
    {
      homeConfigurations = {
        "vjacobs-mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = sharedModules ++ [
            {
              home.username = "victor";
              home.homeDirectory = "/Users/victor";
            }
          ];
        };

        "vjacobs-linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = sharedModules ++ [
            {
              home.username = "vjacobs";
              home.homeDirectory = "/home/vjacobs";
            }
          ];
        };

      };
    };
}
