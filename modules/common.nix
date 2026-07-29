{ pkgs, ... }:

# System configuration shared by all of Cassandra's macOS machines. Anything
# that is genuinely a property of one machine (its hardware platform, its
# stateVersion, host-specific tweaks) belongs in machines/<name>/default.nix
# instead.

{
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

  system.primaryUser = "cassandra";
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
  nix-homebrew.user = "cassandra";
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
}
