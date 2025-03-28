{
  description = "Cassandra's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-bundle.flake = false;
  };

  outputs = inputs@{ self, flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "aarch64-darwin" ];

    options = {
      flake = flake-parts.lib.mkSubmoduleOptions {
        darwinModules = nixpkgs.lib.mkOption {
          type = nixpkgs.lib.types.lazyAttrsOf types.deferredModule;
          default = { };
          apply = nixpkgs.lib.mapAttrs (k: v: { _file = "${toString moduleLocation}#darwinModules.${k}"; imports = [ v ]; });
          description = ''
          Darwin modules.

          You may use this for reusable pieces of configuration, service modules, etc.
        '';
        };
      };
    };

    imports = [
      ./modules/part.nix
      ./home/orchard.nix
      ./machines/honeycrisp/part.nix
    ];

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#honeycrisp

    # Switch to it using:
    # $ darwin-rebuild switch --flake .#honecrisp

  };
}
