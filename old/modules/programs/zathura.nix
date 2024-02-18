{ config, lib, pkgs, ... }:

{
	programs.zathura = {
		enable = true;
		options = {
			adjust-open = "width";
			selection-clipboard = "clipboard";
		};
	};
}
