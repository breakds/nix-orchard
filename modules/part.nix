{ inputs, ... }:

let self = inputs.self;

in {
  flake.darwinModules = {
    common = import ./common.nix;

    darwin-version = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };

    homebrew = { pkgs, ... }: {
      imports = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ];

      config = {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;

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
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };
      };
    };

    # Cassandra's home environment, shared by every machine she uses. The
    # account short name varies per machine, so it comes from the config
    # rather than being spelled out here.
    home-cassandra = { config, pkgs, ... }: let
      username = config.orchard.username;
    in {
      config = {
        users.users.${username} = {
          name = username;
          home = "/Users/${username}";
        };

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${username} = {config, pkgs, ... }: {
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
    };
  };
}
