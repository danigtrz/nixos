{ config, lib, pkgs, ...}:

{
	programs.neovim = {
		enable = true;
		extraConfig = ''
			luafile $NIXOS_CONFIG/modules/programs/neovim/settings.lua
		'';
		plugins = with pkgs.vimPlugins; [

		];
	};
}
