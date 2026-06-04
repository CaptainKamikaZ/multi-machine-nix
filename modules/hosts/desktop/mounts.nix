{
  fileSystems."/mnt/share/media" = {
    device = "//192.168.0.30/media";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "credentials=/etc/nixos/smb-secrets"
      "uid=1000"
      "gid=3000"
      "file_mode=0664"
      "dir_mode=0775"
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
