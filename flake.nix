{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          # Override direnv to skip tests (they fail on macOS)
          direnv = prev.direnv.overrideAttrs (_old: {
            doCheck = false;
          });
        })
      ];
    };

    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.aarch64-darwin.default = pkgs.mkShell {
      packages = with pkgs; [
        nil
        alejandra
        statix
      ];
    };

    homeConfigurations = {
      "vjacobs-mac" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit pkgsUnstable;
        };

        modules =
          [./home.nix]
          ++ [
            {
              home.username = "victor";
              home.homeDirectory = "/Users/victor";
            }
          ];
      };
    };
  };
}
