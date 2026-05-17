{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    NIRI_ENV_FILE = "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh";
  };

  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "bash" "-lc" "source $NIRI_ENV_FILE && noctalia-shell"

    ${builtins.readFile ./dotfiles/niri/config.kdl}
  '';
}
