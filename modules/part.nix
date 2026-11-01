{ inputs, ... }:

let self = inputs.self;

in {
  flake.darwinModules = {
    common = import ./common.nix;

    darwin-version = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };

    homebrew = { config, pkgs, ... }: {
      imports = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ];

      config = {
        nix-homebrew = {
          enable = true;

          # homebrew/homebrew-bundle is deliberately absent: the tap was
          # archived after `brew bundle` moved into Homebrew itself, so
          # tapping it pins a dead repository that Homebrew then tries to
          # write to inside the read-only Nix store.
          taps = {
            "homebrew/homebrew-core" = inputs.homebrew-core;
            "homebrew/homebrew-cask" = inputs.homebrew-cask;
          };

          # Fully declarative tap management. Taps can no longer be added
          # imperatively with `brew tap`.
          mutableTaps = false;
        };

        homebrew = {
          enable = true;

          # The Brewfile must declare the taps nix-homebrew provides.
          # `onActivation.cleanup` runs `brew bundle cleanup`, which removes
          # anything the Brewfile does not mention -- taps included -- so
          # leaving this unset makes activation try to untap homebrew/cask
          # on every run.
          taps = builtins.attrNames config.nix-homebrew.taps;

          onActivation.cleanup = "zap";
          # Update Homebrew and its pinned taps through the flake inputs.
          onActivation.autoUpdate = false;
          onActivation.upgrade = true;
        };
      };
    };

    # Personal home settings apply to the account selected by each machine.
    home-cassandra = { config, ... }: {
      home-manager.users.${config.system.primaryUser} = { ... }: {
        imports = [
          ./home-cassandra/ssh.nix
          ./home-cassandra/zsh.nix
          ./home-cassandra/git.nix
          ./home-cassandra/karabiner  # keybindings
        ];

        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };

        programs.fzf = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          defaultOptions = [ "--height 50%" "--border" ];
        };

        xdg.enable = true;

        home.stateVersion = "25.05";
      };
    };

    home-breakds = { config, ... }: {
      home-manager.users.${config.system.primaryUser} = {
        imports = [
          ./home-breakds
          inputs.nixos-home.homeModules.syncthing
        ];

        services.syncthing.enable = true;
      };
    };
  };
}
