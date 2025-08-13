{
  description = "Flake for my personal website and blog";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      pkgsForSystem = system: (import nixpkgs { inherit system; });

    in {
      devShells = forAllSystems (system:
        let pkgs = pkgsForSystem system;
        in {
          default = pkgs.mkShell {
            packages = [
              # (pkgs.nodePackages_latest.nodejs.overrideAttrs
              #   (final: prev: { enableNpm = false; })) # NodeJS without NPM
              pkgs.nodePackages_latest.nodejs
              pkgs.nodePackages_latest.prettier
              pkgs.pnpm
              pkgs.typescript
              pkgs.typescript-language-server
              pkgs.astro-language-server
            ];
          };
        });
    };
}
