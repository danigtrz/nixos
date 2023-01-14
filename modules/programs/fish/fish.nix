{ config, lib, pkgs, ... }:

{
	programs.fish = {
		enable = true;
		shellAliases = {
			r = "ranger";
			re = "sudo nixos-rebuild switch --flake '.#'";
		};
	};
	home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
}