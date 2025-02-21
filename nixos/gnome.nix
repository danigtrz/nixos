{ inputs, pkgs, config, ... }:

{
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		displayManager.gnome.enable = true;
	};

	environment.gnome.excludePackages = (with pkgs; [
		atomix
		cheese
		epiphany
		evince
		geary
		gedit
		gnome-characters
		gnome-music
		gnome-photos
		gnome-terminal
		gnome-tour
		hitori
		iagno
		tali
		totem
	]);

	programs.dconf.enable = true;

	environment.systemPackages = [
		adwaita-icon-theme
		pkgs.gnomeExtensions.appindicator
	];

	services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
