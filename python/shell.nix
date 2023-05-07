{ pkgs ? import <nixpkgs> { } }:
let
  myAppEnv = pkgs.poetry2nix.mkPoetryEnv {
    projectDir = ./.;
    preferWheels = true;
  };
in
myAppEnv.env.overrideAttrs (oldAttrs: {
  buildInputs = [ pkgs.python310Packages.pip ];
})
