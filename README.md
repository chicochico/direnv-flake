# Direnv plus nix flakes example
This repository contains an example of a `.envrc` which loads the environment defined in the `flake.nix`.

A `shell.nix` is also included, it can be loaded with the `.envrc` with:
```
use nix
```
