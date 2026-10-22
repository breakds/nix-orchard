{ ... }:

# sweetango: MacBook Air M5. Everything Cassandra's machines have in common
# lives in modules/common.nix; laptop-specific settings (trackpad, battery
# indicator, sleep timings) belong here if they are ever wanted.

{
  # Apple Silicon.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # localHostName defaults to hostName, and it is what `darwin-rebuild`
  # reads to pick a configuration when no flake attribute is given.
  networking.hostName = "sweetango";
  networking.computerName = "sweetango";

  # This machine's macOS account was set up as "shanqi" rather than the
  # usual "cassandra".
  orchard.username = "shanqi";

  # Used for backwards compatibility; read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;
}
