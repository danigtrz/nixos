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

	home-manager.users.rafa = {
		programs.waybar = {
			enable = true;
			# systemd?
			style = ''
				* {
					font-family: 'FiraCode Nerd Font';
					color: white;
				}

				window#waybar {
					background: rgba(80, 80, 80, 0.5);
				}

				.modules-left {
					margin-left: 12px;
				}

				.modules-right {
					margin-right: 24px;
				}
			'';
			settings = [{
				"layer" = "top";
				"spacing" = 56;
				"modules-left" = [
					"hyprland/workspaces"
				];
				"modules-center" = [
					"custom/music"
				];
				"modules-right" = [
					"backlight"
					"wireplumber"
					"battery"
					"clock#date"
					"clock#time"
				];
				"custom/launcher" = {
					"format" = "{icon}";
					"format-icons" = "";
					"on-click" = "wofi --show drun";
				};
				"hyprland/workspaces" = {
					"on-click" = "activate";
				};
				"custom/music" = {
					"exec" = "playerctl metadata artist | tr -d '\n' && echo ' - ' | tr -d '\n' && playerctl metadata title | tr -d '\n'";
					"interval" = 1;
					"max-length" = 80;
				};
				"backlight" = {
					"format" = "L {percent}%";
				};
				"wireplumber" = {
					"format" = "V {volume}%";
					"format-muted" = "Muted";
					"tooltip" = "false";
				};
				"battery" = {
					"format" = "B {capacity}%";
					"tooltip" = "false";
				};
				"clock#date" = {
					"format" = "{:%a, %b %e}";
				};
				"clock#time" = {
					"format" = "{:%H:%M}";
				};
			}];
		};
	};
}
