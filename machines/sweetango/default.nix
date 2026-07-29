{ ... }:

# sweetango: MacBook Air M5. Everything Cassandra's machines have in common
# lives in modules/common.nix; laptop-specific settings (trackpad, battery
# indicator, sleep timings) belong here if they are ever wanted.

{
  # The platform the configuration will be used on. Apple Silicon, same as
  # honeycrisp.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # localHostName defaults to hostName, and it is what `darwin-rebuild`
  # reads to pick a configuration when no flake attribute is given.
  networking.hostName = "sweetango";
  networking.computerName = "sweetango";

  # Fresh installation, so this starts at the current maximum rather than
  # inheriting honeycrisp's 6.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;
}
