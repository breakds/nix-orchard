{ config, pkgs, lib, ... }:

let cassandra-zen = "~/.ssh/cassandra_zen";
    cassandra-rsa = "~/.ssh/cassandraqs_rsa";

in {
  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      # Blocks use upstream ssh_config(5) directive names. The "*" block is
      # always emitted last, so the more specific blocks below win.
      settings = {
        "*" = {
          IdentityFile = cassandra-rsa;
          HashKnownHosts = true;
        };

        "github.com" = {
          IdentityFile = cassandra-zen;
          User = "git";
        };

        "bitbucket.org" = {
          IdentityFile = cassandra-zen;
          User = "git";
        };

        "flash-v3-dev" = {
          HostName = "10.0.151.39";
          User = "ec2-user";
          IdentityFile = "~/.ssh/a2s-private-1.pem";
        };

        "10.0.47.81" = {
          HostName = "10.0.47.81";
          User = "ubuntu";
        };

        "3.220.193.183" = {
          HostName = "3.220.193.183";
          User = "ubuntu";
        };

        "3.210.226.122" = {
          HostName = "3.210.226.122";
          User = "ubuntu";
          ForwardAgent = true;
        };

        "3.223.244.153" = {
          HostName = "3.223.244.153";
          User = "ec2-user";
        };

        "pool-v6-dev" = {
          HostName = "10.0.16.6";
          User = "ubuntu";
          IdentityFile = "~/.ssh/a2s-public-1.pem";
        };

        "cube_service" = {
          HostName = "10.0.47.81";
          User = "ubuntu";
          IdentityFile = "~/.ssh/a2s-private-1.pem";
        };

        "flash-v6-dev" = {
          HostName = "10.0.26.247";
          User = "ec2-user";
          IdentityFile = "~/.ssh/a2s-public-1.pem";
        };

        "flash-v6-prod" = {
          HostName = "18.215.42.206";
          User = "ec2-user";
          IdentityFile = "~/.ssh/a2s-public-1.pem";
        };

        "a2s-loader-batch" = {
          HostName = "10.0.151.39";
          User = "ubuntu";
          IdentityFile = "~/.ssh/a2s-public-1.pem";
        };

        "flash-v3-prod" = {
          HostName = "52.23.15.34";
          User = "ubuntu";
        };

        "Flash-controller-v6" = {
          HostName = "3.232.126.254";
          User = "ubuntu";
        };

        "shell-DEV" = {
          HostName = "52.20.31.77";
          User = "ubuntu";
          ForwardAgent = true;
        };

        "shell-PROD" = {
          HostName = "18.211.151.230";
          User = "ubuntu";
          ForwardAgent = true;
        };

        "voyager38" = {
          HostName = "18.215.164.197";
          User = "ubuntu";
        };

        "general-purpose-host" = {
          HostName = "10.0.136.104";
          User = "ubuntu";
        };

        "sbng-host" = {
          HostName = "34.225.255.153";
          User = "ubuntu";
        };

        "sbng-PROD" = {
          HostName = "23.20.131.52";
          User = "ubuntu";
        };

        "voyager-dev" = {
          HostName = "54.208.118.154";
          User = "ubuntu";
        };

        "orchard" = {
          HostName = "10.77.1.157";
          User = "cassandra";
          IdentityFile = "~/.ssh/cassandra_zen";
        };

        "pool-v6-prod" = {
          HostName = "44.205.53.35";
          User = "ubuntu";
          IdentityFile = "~/.ssh/a2s-public-1.pem";
        };
      };
    };
  };
}
