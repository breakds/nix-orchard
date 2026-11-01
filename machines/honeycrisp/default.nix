{ config, pkgs, ... }:

# honeycrisp: Break's Mac Mini M4, freshly reset.

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "honeycrisp";
  networking.computerName = "honeycrisp";

  system.primaryUser = "breakds";

  home-manager.users.${config.system.primaryUser} = { config, lib, ... }: {
    services.syncthing.settings.folders.workspace.path =
      lib.mkForce "${config.home.homeDirectory}/workspace";
  };

  environment.systemPackages = [ pkgs.localsend ];

  homebrew.casks = [ "orcaslicer" ];

  # Fresh installation; keep this value when updating inputs.
  system.stateVersion = 7;
}
