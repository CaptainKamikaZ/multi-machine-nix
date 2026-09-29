{ pkgs, ... }:

{
  systemd.user.services.polkit-agent = {
    Unit.Description = "Polkit Authentication Agent";
    Service.ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
    Install.WantedBy = [ "default.target" ];
  };
}
