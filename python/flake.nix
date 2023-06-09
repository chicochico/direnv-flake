{
  description = "Python env using poetry2nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.foo = pkgs.mkShell {
          buildinputs = [
            (pkgs.poetry2nix.mkPoetryEnv {
              projectDir = ./.;
              preferWheels = true;
            })
          ];
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ python310 pipenv ];
        };
      });
}
