{ config, lib, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
        ];
    };
}
