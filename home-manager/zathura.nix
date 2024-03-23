{ pkgs, config, lib, ... }:

{
	programs.zathura = {
		enable = true;
		options = {
			selection-clipboard = "clipboard";
			guioptions = "none";
		};
	};
}