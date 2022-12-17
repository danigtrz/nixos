{ config, pkgs, ... }:

{
  home.username = "rafa";
  home.homeDirectory = "/home/rafa";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
