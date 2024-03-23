{ pkgs, config, lib, ... }:

{
	home.sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		# extraPackages = with pkgs; [ "gcc" ];
	};

	xdg.configFile.nvim.source = ../nvim;
}