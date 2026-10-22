{ pkgs, ... }:

# sweetango: Cassandra's MacBook Air M5.

{
  # Apple Silicon.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # localHostName defaults to hostName, and it is what `darwin-rebuild`
  # reads to pick a configuration when no flake attribute is given.
  networking.hostName = "sweetango";
  networking.computerName = "sweetango";

  system.primaryUser = "shanqi";

  environment.systemPackages = with pkgs; [
    iterm2
    git
    lsd
    bat
  ];

  system.defaults = {
    dock.autohide = true;
    NSGlobalDomain.AppleICUForce24HourTime = true;
    ".GlobalPreferences"."com.apple.mouse.scaling" = 2.0;
  };

  nix-homebrew.enableRosetta = true;
  homebrew = {
    brews = [ "mas" ];
    casks = [
      "iina"
      "visual-studio-code"
      "karabiner-elements"
    ];
  };

  # Used for backwards compatibility; read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;
}
