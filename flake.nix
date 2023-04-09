{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            hello
            python311
            # pip is not needed since we declare dependencies in this 
            # flake.nix, it can be added however with python311Packages.pip
            python311Packages.requests
          ];
          shellHook = ''
            export FOO=foo
          '';
        };
      });
}
