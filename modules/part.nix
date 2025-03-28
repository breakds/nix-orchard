{ inputs, ... }:

let self = inputs.self;

in {
  flake.darwinModules = {
    darwin-version = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };

    # TODO: Also import nix-homebrew here.
    homebrew = { pkgs, ... }: {
      imports = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ];

      config = {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;

          taps = {
            "homebrew/homebrew-core" = inputs.homebrew-core;
            "homebrew/homebrew-cask" = inputs.homebrew-cask;
            "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
          };

          # Fully declarative tap management. Taps can no longer be added
          # imperatively with `brew tap`.
          mutableTaps = false;
        };

        homebrew = {
          enable = true;
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };
      };
    };

    home-honeycrisp = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      # home-manager.users.cassandra = {config, pkgs, ... }: {
      #   programs.direnv = {
      #     enable = true;
      #     nix-direnv.enable = true;
      #     enableBashIntegration = true;
      #     enableZshIntegration = true;
      #   };

      #   home.homeDirectory = "/Users/cassandra";

      #   home.stateVersion = "25.05";
      # };
    };
  };
}
