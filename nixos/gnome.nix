{ inputs, pkgs, config, ... }:

{
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
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

	environment.systemPackages = (with pkgs; [
		adwaita-icon-theme
		gnomeExtensions.appindicator
		gnome-settings-daemon
	]);
}
