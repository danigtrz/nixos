{ inputs, pkgs, config, username, ... }:

{
	programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;
		xwayland.enable = true;
	};

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
	};

	security = {
		polkit.enable = true;
		pam.services.ags = {};
	};

	environment.systemPackages = with pkgs; [
		brightnessctl
		wl-clipboard
		wlr-randr
		grim
		slurp
		swww
		wofi
	];

	services = {
		gvfs.enable = true;
		devmon.enable = true;
		udisks2.enable = true;
		upower.enable = true;
		accounts-daemon.enable = true;
	};

	nix.settings = {
		substituters = [
			"https://hyprland.cachix.org"
		];
		trusted-public-keys = [
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		];
	};
}