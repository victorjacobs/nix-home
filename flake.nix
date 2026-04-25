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

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    sharedModules = [
      ./home.nix
    ];

    # Override direnv to skip tests (they fail on macOS)
    sharedOverlays = [
      (final: prev: {
        direnv = prev.direnv.overrideAttrs (_old: {
          doCheck = false;
        });
      })
    ];

    macPkgs = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
      overlays = sharedOverlays;
    };
  in {
    devShells.aarch64-darwin.default = macPkgs.mkShell {
      packages = with macPkgs; [
        nil
        alejandra
        statix
      ];
    };

    homeConfigurations = {
      "vjacobs-mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = macPkgs;
        modules =
          sharedModules
          ++ [
            {
              home.username = "victor";
              home.homeDirectory = "/Users/victor";
            }
          ];
      };

      "vjacobs-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = sharedOverlays;
        };
        modules =
          sharedModules
          ++ [
            {
              home.username = "vjacobs";
              home.homeDirectory = "/home/vjacobs";
            }
          ];
      };
    };
  };
}
