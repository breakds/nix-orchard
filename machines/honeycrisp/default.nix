{ ... }:

# honeycrisp: Mac Mini M4. Everything Cassandra's machines have in common
# lives in modules/common.nix.

{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
