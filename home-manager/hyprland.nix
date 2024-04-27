{ inputs, pkgs, config, ... }:

let
	hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
	plugins = inputs.hyprland-plugins.packages.${pkgs.system};
in
{
	home.sessionVariables = {
		QT_QPA_PLATFORMTHEME = "gtk3";
		QT_SCALE_FACTOR = "1";
		MOZ_ENABLE_WAYLAND = "1";
		SDL_VIDEODRIVER = "x11";
		QT_QPA_PLATFORM = "wayland";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
		QT_AUTO_SCREEN_SCALE_FACTOR = "1";
		CLUTTER_BACKEND = "wayland";
		NIXOS_OZONE_WL = "1";
		XDG_CURRENT_DESKTOP = "Hyprland";
		XDG_SESSION_DESKTOP = "Hyprland";

		_JAVA_AWT_WM_NONREPARENTING = "1";
		XCURSOR_SIZE = "24";

		XDG_SESSION_TYPE = "wayland";
		WLR_NO_HARDWARE_CURSORS = "1";
		LIBVA_DRIVER_NAME = "nvidia";
		# GBM_BACKEND = "nvidia-drm";
		# __GLX_VENDOR_LIBRARY_NAME = "nvidia";
	};

	wayland.windowManager.hyprland = {
		enable = true;
		package = hyprland;
		systemd.enable = true;
		xwayland.enable = true;

		settings = {
			exec-once = [
				"ags"
				# "swww-daemon"
				"fcitx5"
				"hyprctl setcursor Bibata-Modern-Ice 24"
			];

			monitor = [
				"eDP-1,preferred,auto,1.33"
				",preferred,auto,1"
			];

			general = {
				layout = "dwindle";

				gaps_in = 6;
				gaps_out = 12;
				border_size = 2;
				
				"col.active_border" = "rgba(cba6f7ee) rgba(f5c2e7ee) 45deg";
				"col.inactive_border" = "rgba(1e1e2eff)";			
			};

			misc = {
				disable_hyprland_logo = true;
			};

			input = {
				kb_layout = "us";
				kb_variant = "altgr-intl";
				follow_mouse = 2;
				
				touchpad = {
					natural_scroll = "yes";
					scroll_factor = 0.7;
					clickfinger_behavior = true;
				};
			};

			dwindle = {
				pseudotile = "yes";
				preserve_split = "yes";
			};

			gestures = {
				workspace_swipe = true;
				# workspace_swipe_distance = 300;
			};

			decoration = {
				rounding = 8;
				drop_shadow = "no";
				# shadow_range = 4;
				# shadow_render_power = 3;
				# "col.shadow" = "rgba(1a1a1aee)";
			};

			animations = {
				enabled = "yes";
				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
				animation = [
					"windows, 1, 7, myBezier"
					"windowsOut, 1, 7, default, popin 80%"
					"border, 1, 10, default"
					"fade, 1, 7, default"
					"workspaces, 1, 6, default"
				];
			};

			windowrule = let
				f = regex: "float, ^(${regex})$";
			in [
				(f "MATLAB R2023b - academic use")
				# "opacity 0.8 0.8,^(kitty)$"
				"tile,title:^(MATLAB R2023b - academic use)$"
				"windowdance,^(MATLAB R2023b - academic use)$"
				"noinitialfocus,^(MATLAB R2023b - academic use)$"
			];

			bind = [
				"SUPER, Q, killactive,"
				"SUPER, F, fullscreen,"
				"SUPER, V, togglefloating,"
				"SUPER, P, pseudo,"
				"SUPER, J, togglesplit,"
				"SUPER SHIFT, M, exit,"

				"SUPER, R, exec, ags -t applauncher"

				"SUPER, Return, exec, kitty"

				", XF86Launch3, exec, grim -g \"$(slurp)\""

				"SUPER, left, movefocus, l"
				"SUPER, right, movefocus, r"
				"SUPER, up, movefocus, u"
				"SUPER, down, movefocus, d"

				"SUPER, 1, workspace, 1"
				"SUPER, 2, workspace, 2"
				"SUPER, 3, workspace, 3"
				"SUPER, 4, workspace, 4"
				"SUPER, 5, workspace, 5"
				"SUPER, 6, workspace, 6"
				"SUPER, 7, workspace, 7"
				"SUPER, 8, workspace, 8"
				"SUPER, 9, workspace, 9"
				"SUPER, 0, workspace, 10"

				"SUPER SHIFT, 1, movetoworkspace, 1"
				"SUPER SHIFT, 2, movetoworkspace, 2"
				"SUPER SHIFT, 3, movetoworkspace, 3"
				"SUPER SHIFT, 4, movetoworkspace, 4"
				"SUPER SHIFT, 5, movetoworkspace, 5"
				"SUPER SHIFT, 6, movetoworkspace, 6"
				"SUPER SHIFT, 7, movetoworkspace, 7"
				"SUPER SHIFT, 8, movetoworkspace, 8"
				"SUPER SHIFT, 9, movetoworkspace, 9"
				"SUPER SHIFT, 0, movetoworkspace, 10"

				"SUPER, mouse_down, workspace, e+1"
				"SUPER, mouse_up, workspace, e-1"

				# rotate screen
				"SUPER_SHIFT, left, exec, hyprctl keyword monitor eDP-1,preferred,auto,1.33,transform,3"
				"SUPER_SHIFT, right, exec, hyprctl keyword monitor eDP-1,preferred,auto,1.33,transform,1"
				"SUPER_SHIFT, up, exec, hyprctl keyword monitor eDP-1,preferred,auto,1.33,transform,2"
				"SUPER_SHIFT, down, exec, hyprctl keyword monitor eDP-1,preferred,auto,1.33,transform,0"
			];

			bindl = [
				", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			];

			bindle = [
				", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
				", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"

				", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
				", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
			];

			bindm = [
				"SUPER, mouse:272, movewindow"
				"SUPER, mouse:273, resizewindow"
			];
		};
	};
}
