{ inputs, pkgs, config, ... }:

{
	services = {
		xserver.enable = true;
		displayManager = {
			sddm.enable = true;
			sddm.wayland.enable = true;
			defaultSession = "plasma";
		};
		desktopManager.plasma6.enable = true;
	};

	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		konsole
		oxygen
	];

	programs.dconf.enable = true;

	qt = {
		enable = true;
		platformTheme = "gnome";
		style = "adwaita-dark";
	};
}
