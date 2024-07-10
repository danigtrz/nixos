{ inputs, pkgs, config, username, ... }:

{
	programs.hyprland.enable = true;

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
	};

	security = {
		polkit.enable = true;
		pam.services = {
			ags = {};
			swaylock = {};
		};
	};

	environment.systemPackages = with pkgs; [
		brightnessctl
		wl-clipboard
		wlr-randr
		grim
		slurp
		swww
	];

	nix.settings = {
		substituters = [
			"https://hyprland.cachix.org"
		];
		trusted-public-keys = [
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		];
	};
}
