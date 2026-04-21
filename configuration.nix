{ config, pkgs, lib, self, ... }:

{
  ############################################################
  # Imports
  ############################################################
  imports = [
    ./hardware-configuration.nix
  ];


  ############################################################
  # Bootloader
  ############################################################
  boot.loader.systemd-boot.enable = false;
  #boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi = { 
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };
  boot.loader.timeout = 5;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 10;
    useOSProber = true;
    theme = pkgs.callPackage (self.outPath + "/grub-theme.nix") {};
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  boot.kernelModules = [ "v4l2loopback" ];

  # Optional but recommended for OBS
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';


  ###########################################################
  # Nix Settings
  ###########################################################
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  ###########################################################
  # NVIDIA (Offload-Only + Sleep Stability)
  ###########################################################

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      sync.enable = false;
      amdgpuBusId = "PCI:0:0:0"; # Fake iGPU
      nvidiaBusId = "PCI:43:0:0"; # Nvidia RTX 3060
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia" "modesetting"];

  ############################################################
  # Bluetooth
  ############################################################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  ############################################################
  # Sound
  ############################################################
  services.pipewire.wireplumber.extraConfig = { 
    "10-dp-audio-activation" = { 
      "monitor.rules" = [ 
        { 
          matches = [ 
            { "device.name" = "alsa_card.pci-0000_2b_00.1"; } 
          ]; 
          actions.update-props = { 
            "api.acp.auto-port" = "true"; 
          }; 
        } 
      ]; 
    }; 
  };


  ############################################################
  # Networking
  ############################################################
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = false;

    defaultGateway = {
      address = "192.168.0.1";
      interface = "enp34s0";
    };

    nameservers = [
      "192.168.0.40"
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces.enp34s0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.0.232";
          prefixLength = 24;
        }
      ];
    };
  };


  ############################################################
  # Locale & Time
  ############################################################
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  ############################################################
  # Desktop Environment (KDE Plasma 6)
  ############################################################
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common.default = [ "kde" ];
    };
  };


  ############################################################
  # Printing
  ############################################################
  services.printing.enable = true;
  hardware.printers.ensurePrinters = [
    {
      name = "hpprinter";
      deviceUri = "ipp://192.168.0.136/ipp/print";
      model = "everywhere";
    }
  ];
  services.printing.defaultShared = false;
  services.printing.listenAddresses = [ "localhost" ];
  services.printing.allowFrom = [ "localhost" ];

  ############################################################
  # Audio (PipeWire)
  ############################################################
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ############################################################
  # User Account
  ############################################################
  users.users.justin = {
    isNormalUser = true;
    description = "Justin Gabrielson";
    extraGroups = [ "networkmanager" "wheel" "docker" "storage" ];
  };

  ############################################################
  # System Programs
  ############################################################
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-move-transition
      obs-transition-table
      obs-pipewire-audio-capture
    ];
  };
  programs.niri.enable = true;

  ############################################################
  # Unfree Packages
  ############################################################
  nixpkgs.config.allowUnfree = true;

  ############################################################
  # System Packages
  ############################################################
  environment.systemPackages = with pkgs; [
    alsa-utils
    brave
    cifs-utils
    davinci-resolve
    gh
    git
    gvfs
    inetutils
    kdePackages.kdenlive
    nextcloud-client
    obs-cmd
    pciutils
    prismlauncher
    protonup-qt
    pulseaudio
    streamcontroller
    tailscale
    temurin-bin-25 #java25
    timeshift
    v4l-utils
    vim
    vlc
    wget

    noctalia
    polkit
    quickshell
    xwayland-satellite
    xfce.thunar
    xfce.tumbler
  ];

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      iosevka
      liberation_ttf
      ubuntu-classic
      hack-font
      cascadia-code
    ];
  };

  environment.variables = {
    GTK_THEME = "Breeze-Dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  ############################################################
  # Samba Mount
  ############################################################
  # START SAMBA MOUNT CONFIG
  fileSystems."/mnt/share/media" = {
    device = "//192.168.0.30/media";
    fsType = "autofs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=3000"];
  };

  # START NFS MOUNT CONFIG
  fileSystems."/mnt/share/data/foundry" = {
    device = "192.168.0.30:/mnt/tank/data/foundry";
    fsType = "nfs4";
    options = [
      "rw"
      "hard"
      "intr"
      "nfsvers=4.2"
    ];
  };


  ############################################################
  # Services
  ############################################################
  services.tailscale.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  ############################################################
  # System State Version
  ############################################################
  system.stateVersion = "25.11";
}
