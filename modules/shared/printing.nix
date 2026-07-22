{
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers.ensurePrinters = [
    {
      name = "hpprinter";
      deviceUri = "ipp://192.168.0.80/ipp/print";
      model = "everywhere";
    }
  ];

  services.printing.defaultShared = false;
  services.printing.listenAddresses = [ "localhost" ];
  services.printing.allowFrom = [ "localhost" ];
  systemd.services.ensure-printers = {
    after = [ "network-online.target" "cups.service" ];
    wants = [ "network-online.target" ];

  serviceConfig = {
      TimeoutStartSec = "5s";
      Restart = "on-failure";
      RestartSec = "30s";
    };
  };
}
