{ config, pkgs, ... }:

{
	home.username = "rafa";
	home.homeDirectory = "/home/rafa";

	gtk = {
		enable = true;
		theme = {
			name = "Catppuccin-Mocha-Pink";
			package = pkgs.catppuccin-gtk;
		};
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
		font = {
			name = "Fira Code";
			size = 11;
		};
	};

	home.stateVersion = "22.11";

	programs.home-manager.enable = true;
}
