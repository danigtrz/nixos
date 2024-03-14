{ pkgs, config, ... }:

{
	programs.thunar = {
		enable = true;
		plugins = with pkgs.xfce; [
			thunar-volman
			thunar-archive-plugin
			thunar-media-tags-plugin
		];
	};

	# save preferences
	programs.xfconf.enable = true;

	services = {
		gvfs.enable = true;
		tumbler.enable = true;
		udisks2.enable = true;
	};
}