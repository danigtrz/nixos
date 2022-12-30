{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		waybar
	];

	nixpkgs.overlays = [
		(final: prev: {
			waybar =
			let
				hyprctl = "${pkgs.hyprland}/bin/hyprctl";
				waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
			in
			prev.waybar.overrideAttrs (oldAttrs: {
				mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
				patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
			});
		})
	];
}
