{ pkgs, ... }:

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

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

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
  nix-homebrew.user = "cassandra";
  homebrew = {
    brews = [
      "mas"
      "imagemagick"
    ];
    casks = [
      "iina"
      "windsurf"
      "visual-studio-code"
      "karabiner-elements"
      "rustdesk"
    ];
  };
}
