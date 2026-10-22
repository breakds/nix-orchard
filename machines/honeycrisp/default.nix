{ ... }:

# honeycrisp: Break's Mac Mini M4, freshly reset.

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "honeycrisp";
  networking.computerName = "honeycrisp";

  system.primaryUser = "breakds";

  # Fresh installation; keep this value when updating inputs.
  system.stateVersion = 7;
}
