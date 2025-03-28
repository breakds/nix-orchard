{ inputs, ... }:

let self = inputs.self;
    nix-darwin = inputs.nix-darwin;
    nix-homebrew = inputs.nix-homebrew;
    home-manager = inputs.home-manager;

in {
  flake.darwinConfigurations."honeycrisp" = nix-darwin.lib.darwinSystem {
    modules = [
      home-manager.darwinModules.home-manager
      self.darwinModules.darwin-version
      self.darwinModules.homebrew
      self.darwinModules.home-honeycrisp
      ./.
    ];
  };
}
