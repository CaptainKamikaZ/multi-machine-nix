{ pkgs, ... }:

{
  xdg.configFile."quickshell/noctalia-shell".source =
    "${pkgs.noctalia}/share/noctalia-shell";
}
