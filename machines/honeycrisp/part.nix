{ inputs, ... }:

let
  inherit (inputs) self nix-darwin nix-homebrew home-manager ml-pkgs;
in {
  flake.darwinConfigurations."honeycrisp" = nix-darwin.lib.darwinSystem {
    modules = [
      ({pkgs, ... }: {
        nixpkgs = {
          overlays = [
            ml-pkgs.overlays.gen-ai
          ];
        };
      })
      home-manager.darwinModules.home-manager
      self.darwinModules.darwin-version
      self.darwinModules.homebrew
      self.darwinModules.home-honeycrisp
      ./.
    ];
  };
}
