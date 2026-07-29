{ ... }:

# sweetango: MacBook Air M5. Everything Cassandra's machines have in common
# lives in modules/common.nix; laptop-specific settings (trackpad, battery
# indicator, sleep timings) belong here if they are ever wanted.

{
  # The platform the configuration will be used on. Apple Silicon, same as
  # honeycrisp.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Fresh installation, so this starts at the current maximum rather than
  # inheriting honeycrisp's 6.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;
}
