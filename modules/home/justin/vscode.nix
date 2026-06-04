{ config, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
            github.copilot
            github.copilot-chat
            ms-azuretools.vscode-containers
            bbenoist.nix
            yzhang.markdown-all-in-one
        ];
    };
}