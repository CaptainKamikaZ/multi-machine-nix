{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.features.networktools.enable {
    environment.systemPackages = with pkgs; [
      # --- Core Diagnostics & Routing ---
      traceroute          # Tracks the path packets take to a host
      mtr                 # Combines ping and traceroute for live diagnostics
      iperf3              # Network bandwidth measurement tool
      ethtool             # Utility for examining/configuring network interface cards
      ipcalc              # IPv4/IPv6 subnet calculator

      # --- DNS & Name Resolution ---
      dnsutils            # Includes dig, nslookup, and host
      dogdns              # A modern, user-friendly alternative to dig

      # --- Packet Analysis & Scanning ---
      nmap                # Network exploration tool and security/port scanner
      tcpdump             # Powerful command-line packet analyzer
      termshark           # A terminal UI for tshark (Wireshark in the CLI)

      # --- Socket & Port Utilities ---
      socat               # Multipurpose relay (bidirectional data transfer)
      netcat-gnu          # The classic networking utility for reading/writing bits
      ncat                # Nmap's feature-rich reimplementation of Netcat

      # --- HTTP & API Testing ---
      curl                # Command line tool for transferring data with URLs
      wget                # Network utility to retrieve files from the web
      httpie              # A user-friendly command-line HTTP client (alternative to curl)

      # --- Hardware & Bandwidth Monitoring ---
      bmon                # Bandwidth monitor and rate estimator
      iftop               # Display bandwidth usage on an interface by host
    ];

    # Allows non-root users to run mtr's interactive ping/traceroute
    programs.mtr.enable = true;
  };
}
