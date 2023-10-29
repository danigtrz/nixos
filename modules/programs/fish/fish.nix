{ config, lib, pkgs, ... }:

{
	programs.fish = {
		enable = false;
		# shellAliases = {
		# 	r = "ranger";
		# 	re = "sudo nixos-rebuild switch --flake '.#'";
		# };
		plugins = with pkgs.fishPlugins; [
			# hydro
		];
	};
	# home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
	home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
}
