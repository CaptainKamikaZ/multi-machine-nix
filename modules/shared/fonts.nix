{ pkgs, ... }:

{
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
}
