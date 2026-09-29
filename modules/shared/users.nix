{ pkgs, lib, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "${username}";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "storage"
      "plugdev"
    ];
    shell = pkgs.fish;

    packages = [];
  };
}
