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
	};

	xdg.configFile.nvim.source = ../nvim;
}