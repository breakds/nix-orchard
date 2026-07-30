{ config, pkgs, lib, ... }:

let cassandra-zen = "~/.ssh/cassandra_zen";
    cassandra-rsa = "~/.ssh/cassandraqs_rsa";

    # Alias of the jump host defined below. Named once so that the blocks
    # using it cannot drift from it.
    jump-host = "work-jump";

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

        # The 10.0.0.0/16 network is only reachable through the tunnel that
        # octavian holds on our behalf, sealed in a container of its own. That
        # tunnel is deliberately split: it carries this one internal network
        # and nothing else, and cannot reach the public internet at all.
        #
        # So `ProxyJump` belongs on the 10.0.x.x blocks below and on nothing
        # else. Putting it on a public address would route a reachable host
        # into a tunnel that drops it, and the failure looks like a hang
        # rather than an error.
        #
        # The account on the far side cannot be logged into -- it exists only
        # to be jumped through -- and it will only open port 22.
        #
        # This is octavian's home-LAN address, not its Tailscale one. From
        # outside the house it resolves because a tailnet node advertises
        # 10.77.1.0/24; octavian's own tailnet address does not currently
        # answer on port 22. So if every internal host stops being reachable
        # at once, suspect subnet advertisement before suspecting the tunnel.
        ${jump-host} = {
          HostName = "10.77.1.131";
          Port = 23122;
          User = "tunnel";
          IdentityFile = cassandra-zen;
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
          ProxyJump = jump-host;
        };

        "flash-v6-dev" = {
          HostName = "10.0.26.247";
          User = "ec2-user";
          IdentityFile = "~/.ssh/a2s-public-1.pem";
          ProxyJump = jump-host;
        };

        "flash-v6-prod" = {
          HostName = "18.215.42.206";
          User = "ec2-user";
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
          ProxyJump = jump-host;
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
