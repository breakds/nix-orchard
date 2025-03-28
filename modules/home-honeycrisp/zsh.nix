{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "ys";
      plugins = [
        "pass"     # pass store auto-completion
        "dotenv"
        "extract"  # decompression general command
        "z"
      ];
    };

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }

      {
        # will source nix-zsh-completions.plugin.zsh
        name = "nix-zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "spwhitt";
          repo = "nix-zsh-completions";
          rev = "0.4.4";
          sha256 = "sha256-Djs1oOnzeVAUMrZObNLZ8/5zD7DjW3YK42SWpD2FPNk=";
        };
      }
    ];

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    initExtra = ''
      # I do not like accepting autosuggestions with right arrow (i.e.
      # forward-char). Only keep end-of-line here.

      ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
        end-of-line
                      )

      # Be fancy!
      ${pkgs.fastfetch}/bin/fastfetch
    '';
  };
}
