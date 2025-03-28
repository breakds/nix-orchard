{ inputs, ... }:

{
  flake.darwinModules = {
    # TODO: Also import nix-homebrew here.
    homebrew = { pkgs, ... }: {
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
        enableRosetta = true;
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };
    };
  };
}
