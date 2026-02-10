{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

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

      macPkgs = nixpkgs.legacyPackages.aarch64-darwin;
    in
    {
      devShells.aarch64-darwin.default = macPkgs.mkShell {
        packages = with macPkgs; [
          nil
          nixpkgs-fmt
        ];
      };

      homeConfigurations = {
        "vjacobs-mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = macPkgs;
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
