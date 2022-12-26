{ config, lib, pkgs, ...}:

{
	programs.neovim = {
		enable = true;
		extraConfig = ''
			luafile /home/rafa/.nixos/modules/programs/neovim/settings.lua
		'';
		plugins = with pkgs.vimPlugins; [
			indentLine
		];
	};
}

