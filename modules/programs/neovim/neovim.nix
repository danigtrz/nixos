{ config, lib, pkgs, ...}:

{
	programs.neovim = {
		enable = true;
		extraConfig = ''
			luafile ./settings.lua
		'';
		plugins = with pkgs.vimPlugins; [

		];
	};
}
