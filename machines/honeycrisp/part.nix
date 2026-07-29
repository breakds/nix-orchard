{ inputs, ... }:

let
  inherit (inputs) self nix-darwin nix-homebrew home-manager;
in {
  flake.darwinConfigurations."honeycrisp" = nix-darwin.lib.darwinSystem {
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
