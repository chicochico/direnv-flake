{
  description = "A basic flake with a shell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    terraform = {
      url = "github:NixOS/nixpkgs/69fcff00d0fbf7d742f31900f46a5c27c5caf85e"; # 1.2.9
    };
  };

  outputs = { self, nixpkgs, flake-utils, terraform }:
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
            python311Packages.ipython
            python311Packages.pandas
          ];
          buildInputs = [
            terraform.legacyPackages.${system}.terraform
          ];
          shellHook = ''
            export FOO=foo
          '';
        };
      });
}
