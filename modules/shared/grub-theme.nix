{ pkgs, ... }:

let
  hyperfluentTheme = pkgs.stdenv.mkDerivation {
    pname = "hyperfluent-grub-theme";
    version = "1.0";

    src = ../../home-manager/grub/hyperfluent-nixos;

    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out/
    '';
  };
in
{
  boot.loader.grub.theme = hyperfluentTheme;
}
