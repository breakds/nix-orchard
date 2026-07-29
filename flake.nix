{
  description = "Cassandra's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
  };

  outputs = inputs@{ self, flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "aarch64-darwin" ];

    imports = [
      # Declares `flake.darwinConfigurations` as an option, so that each
      # machine can contribute its own entry from its own module.
      inputs.nix-darwin.flakeModules.default

      ./modules/part.nix
      ./machines/honeycrisp/part.nix
      ./machines/sweetango/part.nix
    ];

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#honeycrisp

    # Switch to it using:
    # $ darwin-rebuild switch --flake .#honecrisp

  };
}
