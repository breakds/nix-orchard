{ pkgs, ... }:

{
  imports = [ ./starship.nix ];

  home.packages = with pkgs; [
    ripgrep
    zstd
    btop
    hunk
    lsd
    bat
  ];

  programs.zsh.enable = true;
  xdg.enable = true;

  programs.ghostty = {
    enable = true;
    # Native macOS app; pkgs.ghostty is the Linux GTK build.
    package = pkgs.ghostty-bin;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
      window-padding-x = 8;
      window-padding-y = 8;
    };
  };

  # Fresh home environment; keep this value when updating inputs.
  home.stateVersion = "26.11";
}
