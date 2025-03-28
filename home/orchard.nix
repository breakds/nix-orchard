{ inputs, ... }:

let self = inputs.self;

in {
  flake.darwinModules.home-honeycrisp = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.cassandra = {config, pkgs, ... }: {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      
      home.stateVersion = "25.05";
    };
  };
}
