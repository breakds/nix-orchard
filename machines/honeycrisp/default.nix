{ ... }:

# honeycrisp: Mac Mini M4. Everything Cassandra's machines have in common
# lives in modules/common.nix.

{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # localHostName defaults to hostName, and it is what `darwin-rebuild`
  # reads to pick a configuration when no flake attribute is given.
  networking.hostName = "honeycrisp";
  networking.computerName = "honeycrisp";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
