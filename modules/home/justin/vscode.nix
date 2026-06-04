{ config, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
            package = pkgs.vscode.overrideAttrs (old: {
                postFixup = ''
                    wrapProgram $out/bin/code \
                    --set NIXOS_OZONE_WL 1 \
                    --add-flags "--enable-features=WaylandWindowDecorations" \
                    --add-flags "--ozone-platform-hint=auto" \
                    --add-flags "--enable-wayland-ime" \
                    --add-flags "--wayland-text-input-version=3"
                '';
            });
        profiles.default.extensions = with pkgs.vscode-extensions; [
            github.copilot
            github.copilot-chat
            ms-azuretools.vscode-containers
            bbenoist.nix
            yzhang.markdown-all-in-one
        ];
    };
}