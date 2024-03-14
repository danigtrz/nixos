{ pkgs, ... }:

{
	home.sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		extraPackages = [ "gcc" ];
	};

	xdg.configFile.nvim.source = ../nvim;
}