{
  fileSystems."/mnt/share/media" = {
    device = "//192.168.0.30/media";
    fsType = "autofs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=3000"
    ];
  };

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
}
