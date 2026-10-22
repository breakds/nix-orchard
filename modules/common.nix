{ config, pkgs, ... }:

# Shared system settings. Machine preferences live in machines/<name>.

{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    # Chinese fonts.
    wqy_microhei
    font-awesome
  ];

  users.users.${config.system.primaryUser}.home = "/Users/${config.system.primaryUser}";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  nix-homebrew.user = config.system.primaryUser;
}
