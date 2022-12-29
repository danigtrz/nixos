{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      window_padding_width = 8;
      confirm_os_window_close = false;
    };
    font = "Fira Code";
    theme = "Catppuccin-Mocha";
  };
}
