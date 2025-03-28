{ config, pkgs, lib, ... }:

let cassandra-zen = "~/.ssh/cassandra_zen";
    cassandra-rsa = "~/.ssh/cassandraqs_rsa";

in {
  config = {
    programs.ssh = {
      enable = true;
      hashKnownHosts = true;

      matchBlocks = {
        "*" = {
          identityFile = cassandra-rsa;
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

        "10.0.47.81" = {
          hostname = "10.0.47.81";
          user = "ubuntu";
        };

        "3.220.193.183" = {
          hostname = "3.220.193.183";
          user = "ubuntu";
        };

        "3.210.226.122" = {
          hostname = "3.210.226.122";
          user = "ubuntu";
          forwardAgent = true;
        };

        "3.223.244.153" = {
          hostname = "3.223.244.153";
          user = "ec2-user";
        };

        "pool-v6-dev" = {
          hostname = "10.0.16.6";
          user = "ubuntu";
          identityFile = "~/.ssh/a2s-public-1.pem";
        };

        "cube_service" = {
          hostname = "10.0.47.81";
          user = "ubuntu";
          identityFile = "~/.ssh/a2s-private-1.pem";
        };

        "flash-v6-dev" = {
          hostname = "10.0.26.247";
          user = "ec2-user";
          identityFile = "~/.ssh/a2s-public-1.pem";
        };

        "flash-v6-prod" = {
          hostname = "18.215.42.206";
          user = "ec2-user";
          identityFile = "~/.ssh/a2s-public-1.pem";
        };

        "a2s-loader-batch" = {
          hostname = "10.0.151.39";
          user = "ubuntu";
          identityFile = "~/.ssh/a2s-public-1.pem";
        };

        "flash-v3-prod" = {
          hostname = "52.23.15.34";
          user = "ubuntu";
        };

        "Flash-controller-v6" = {
          hostname = "3.232.126.254";
          user = "ubuntu";
        };

        "shell-DEV" = {
          hostname = "52.20.31.77";
          user = "ubuntu";
          forwardAgent = true;
        };

        "shell-PROD" = {
          hostname = "18.211.151.230";
          user = "ubuntu";
          forwardAgent = true;
        };

        "voyager38" = {
          hostname = "18.215.164.197";
          user = "ubuntu";
        };

        "general-purpose-host" = {
          hostname = "10.0.136.104";
          user = "ubuntu";
        };

        "sbng-host" = {
          hostname = "34.225.255.153";
          user = "ubuntu";
        };

        "sbng-PROD" = {
          hostname = "23.20.131.52";
          user = "ubuntu";
        };

        "voyager-dev" = {
          hostname = "54.208.118.154";
          user = "ubuntu";
        };
      };
    };
  };
}
