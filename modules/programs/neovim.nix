{ config, lib, pkgs, ...}:

{
	programs.neovim = {
		enable = true;
		extraConfig = ''
			set number
			set tabstop=4
			set shiftwidth=4
		'';
		plugins = [
			pkgs.vimPlugins.nvim-tree-lua
		];
	};
}
