{ config, lib, pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        settings = {
            enable_audio_bell = false;
            window_padding_width = 8;
            confirm_os_window_close = 0;
        };
        font.name = "Fira Code";
        theme = "Catppuccin-Mocha";
    };
}
