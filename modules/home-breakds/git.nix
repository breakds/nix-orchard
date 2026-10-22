{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = lib.mkDefault pkgs.gitFull;

    signing = {
      format = "ssh";
      key = "~/.ssh/breakds_honeycrisp";
      signByDefault = true;
    };

    ignores = [
      "*~"
      ".direnv"
      ".envrc"
      ".goose"
      ".aider*"
      "result"
    ] ++ lib.splitString "\n" (builtins.readFile ./gitignore);

    includes = [
      {
        condition = "gitdir:~/projects/psynk.ai/";
        contents.user.email = "breakds@psynk.ai";
      }
    ];

    settings = {
      user.name = lib.mkDefault "Break Yang";
      user.email = lib.mkDefault "breakds@gmail.com";

      pull.rebase = true;
      init.defaultBranch = "master";
      advice.addIgnoredFile = false;
      http.version = "HTTP/1.1";

      column.ui = "auto";
      branch.sort = "-committerdate";
      diff.algorithm = "histogram";

      push.autoSetupRemote = true;
      push.followTags = true;

      fetch.prune = true;
      fetch.pruneTags = true;
      fetch.all = true;

      help.autocorrect = "prompt";
      rerere.enable = true;
      rerere.autoupdate = true;
      log.date = "iso";
      apply.whitespace = "fix";

      alias.logall = "log --graph --abbrev-commit --decorate --date=short --format=format:'%C(bold cyan)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)%an%C(reset) %C(bold yellow)%d%C(reset)' --branches --remotes --tags";
    };
  };

  programs.difftastic.enable = true;
}
