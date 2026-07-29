{ inputs, ... }:

let
  inherit (inputs) self nix-darwin home-manager;
in {
  flake.darwinConfigurations."sweetango" = nix-darwin.lib.darwinSystem {
    modules = [
      home-manager.darwinModules.home-manager
      self.darwinModules.common
      self.darwinModules.darwin-version
      self.darwinModules.homebrew
      self.darwinModules.home-cassandra
      ./.
    ];
  };
}
