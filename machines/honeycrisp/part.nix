{ inputs, ... }:

let self = inputs.self;
    nix-darwin = inputs.nix-darwin;
    nix-homebrew = inputs.nix-homebrew;
    home-manager = inputs.home-manager;

in {
  flake.darwinConfigurations."honeycrisp" = nix-darwin.lib.darwinSystem {
    modules = [
      nix-homebrew.darwinModules.nix-homebrew
      home-manager.darwinModules.home-manager
      self.darwinModules.homebrew
      ./.
    ];
  };
}
