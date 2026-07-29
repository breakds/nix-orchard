{ config, lib, pkgs, ... }:

# System configuration shared by all of Cassandra's macOS machines. Anything
# that is genuinely a property of one machine (its hardware platform, its
# stateVersion, its account name, host-specific tweaks) belongs in
# machines/<name>/default.nix instead.

{
  options.orchard.username = lib.mkOption {
    type = lib.types.str;
    default = "cassandra";
    description = ''
      Short name of the macOS account Cassandra uses on this machine.

      This is the account name macOS was set up with, which is not always
      the same from machine to machine. It is unrelated to her git identity
      and to the remote usernames in the ssh config.
    '';
  };

  config = {
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

    nixpkgs.config.allowUnfree = true;

    system.primaryUser = config.orchard.username;
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
    nix-homebrew.user = config.orchard.username;
    homebrew = {
      brews = [
        "mas"
        "imagemagick"
      ];
      casks = [
        "iina"
        "visual-studio-code"
        "karabiner-elements"
      ];
    };
  };
}
