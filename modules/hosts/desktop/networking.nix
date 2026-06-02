{
  networking = {
    hostName = "desktop";
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
}
