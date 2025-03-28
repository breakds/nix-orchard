{
  description = "Cassandra's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

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

  outputs = inputs@{ self, nix-darwin, nix-homebrew, home-manager, nixpkgs, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        iterm2
        git
        lsd
        bat
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.defaults = {
        dock.autohide = true;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        ".GlobalPreferences"."com.apple.mouse.scaling" = 2.0;
      };

      # Install the fonts
      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.inconsolata
        nerd-fonts.jetbrains-mono
        # Add Wenquanyi Microsoft Ya Hei, a nice-looking Chinese font.
        wqy_microhei
        font-awesome
      ];

      # Homebrew
      nix-homebrew = {
        user = "cassandra";

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
        brews = [
          "mas"
          "imagemagick"
        ];
        casks = [
          "iina"
          "windsurf"
        ];
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };
    };
  in {
    imports = [
      ./home/orchard.nix
    ];
    
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."honeycrisp" = nix-darwin.lib.darwinSystem {
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        self.darwinModules.honeycrisp-home
        configuration
      ];
    };
  };
}
