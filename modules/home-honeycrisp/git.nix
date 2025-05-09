{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = lib.mkDefault pkgs.gitAndTools.gitFull;
    userName = lib.mkDefault "Shan Qi";
    userEmail = lib.mkDefault "cassandraqs@gmail.com";

    signing = {
      key = "cassandraqs@gmail.com";
      # Disabled because otherwise it will ask me to type the password
      # for the GPG key every time. Maybe until I figure out the GPG
      # agent thing.
      signByDefault = false;
    };

    extraConfig = {
      pull.rebase = true;
      advice.addIgnoredFile = false;
      http.version = "HTTP/1.1";
    };

    aliases = {
      # Copied from Kiran Rao: https://kiranrao.ca/2024/06/21/git-config.html
      logall = "log --graph --abbrev-commit --decorate --date=short --format=format:'%C(bold cyan)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)%an%C(reset) %C(bold yellow)%d%C(reset)' --branches --remotes --tags";
    };
  };
}
