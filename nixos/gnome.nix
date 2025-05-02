{ inputs, pkgs, config, ... }:

{
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome = {
			enable = true;
			extraGSettingsOverridePackages = [ pkgs.mutter ];
			extraGSettingsOverrides = ''
				[org.gnome.mutter]
				experimental-features=['scale-monitor-framebuffer']
			'';
		};
	};

	environment.gnome.excludePackages = (with pkgs; [
		atomix
		cheese
		epiphany
		evince
		geary
		gedit
		gnome-characters
		gnome-maps
		gnome-music
		gnome-photos
		gnome-terminal
		gnome-tour
		gnome-contacts
		hitori
		iagno
		orca
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
