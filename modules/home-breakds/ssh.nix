{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      IdentityFile = "~/.ssh/breakds_honeycrisp";
      HashKnownHosts = true;
      UserKnownHostsFile = "~/.ssh/known_hosts";
      ForwardAgent = false;
      AddKeysToAgent = "no";
      Compression = false;
      ServerAliveInterval = 0;
      ServerAliveCountMax = 3;
      ControlMaster = "auto";
      ControlPersist = "600s";
      ControlPath = "~/.ssh/cm-%C";
    };
  };
}
