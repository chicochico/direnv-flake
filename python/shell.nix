{ pkgs ? import <nixpkgs> { } }:
let
  myAppEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python38;
    projectDir = ./.;
    preferWheels = true;
  };
in
myAppEnv.env.overrideAttrs (oldAttrs: {
  buildInputs = [ pkgs.python38Packages.pip ];
})
