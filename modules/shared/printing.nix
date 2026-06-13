{
  services.printing.enable = true;
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
  };
}
