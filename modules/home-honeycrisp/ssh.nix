{ config, pkgs, lib, ... }:

let cassandra-zen = "~/.ssh/cassandra_zen";

in {
  config = {
    programs.ssh = {
      enable = true;
      hashKnownHosts = true;

      matchBlocks = [
        "*" = {
          identityFile = cassandra-zen;
        };

        "github.com" = {
          identityFile = cassandra-zen;
          user = "git";
        };

        "bitbucket.org" = {
          identityFile = cassandra-zen;
          user = "git";
        };

        "flash-v3-dev" = {
          hostname = "10.0.151.39";
          user = "ec2-user";
          identityFile = "~/.ssh/a2s-private-1.pem";
        };
      ];
    };
  };
}
